import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../../templates"

Rectangle {
    id: root

    TemplateButton {
        id: nothingIcon
        visible: !search.found
        height: 90
        width: 90
        enabled: false
        iconHeight: 80
        iconWidth: 80
        iconSource: "../resources/icons/nothing.png"
        colorOverlayDefault: "gray"
        colorOverlayMouseOver: "gray"
        colorOverlayClicked: "gray"
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: search.bottom
            topMargin: 30
        }
    }
    Text {
        text: qsTr("Никого не удалось найти.")
        font.pointSize: 12
        visible: !search.found
        color: "gray"
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: nothingIcon.bottom
            topMargin: 1
        }
    }

    TextField {
        id: search
        property bool found: true
        height: 40
        placeholderText: qsTr("Поиск...")
        selectByMouse: true
        focusReason: Qt.MouseFocusReason
        font.pixelSize: 18
        maximumLength: 20
        verticalAlignment: TextInput.AlignVCenter
        color: "whitesmoke"
        leftPadding: 12
        background: Rectangle {
            color: "transparent"
            Rectangle {
                height: 2
                color: "#333333"
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 0
                    verticalOffset: -2
                    color: "#20000000"
                }
            }
        }
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        onTextEdited: {
            contactModel.clear()
            contactList.selectedIndex = -1
            let users = service.search(text)
            search.found = (users.length == 0) ? false : true
            for (let key in users) {
                let user = users[key]
                contactModel.append({
                    contactName: [user[3], user[2]].join(' '),
                    lastMessage: "Пока нет ни одного сообщения.",
                    lastMessageTime: " ",
                    contactLogin: user[1],
                    contactId: user[0],
                })
            }
        }
    }

    ListModel {
        id: contactModel
    }

    Component {
        id: contact
        
        Rectangle {
            id: contactBlock
            color:  index == contactList.selectedIndex ? "#4d4c4c" : isMouseHovered() ? "#424242" : "#333333"
            height: 70
            width: root.width

            Component.onCompleted: {
                if (model.contactId === messenger.getTarget()) {
                    contactList.selectedIndex = index
                }
            }

            
            Rectangle {
                width: parent.width * 0.9
                height: 1
                color: "#636363"
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                visible: index + 1 == contactList.model.count ? false : true
            }
            

            Text {
                id: contactName
                text: model.contactName
                color: "whitesmoke"
                font.pointSize: 11
                anchors {
                    top: parent.top
                    left: parent.left
                    leftMargin: 10
                    topMargin: 10
                }
            }

            Text {
                id: lastMessageTime
                text: model.lastMessageTime
                color: "#787878"
                visible: !isMouseHovered()
                font.pointSize: 11
                anchors {
                    top: parent.top
                    right: parent.right
                    rightMargin: 10
                    topMargin: 10
                }
            }

            Text {
                text: model.lastMessage
                color: "#787878"
                font.pointSize: 11
                anchors {
                    bottom: parent.bottom
                    bottomMargin: 15
                    left: parent.left
                    leftMargin: 10
                }
            }

            MouseArea {
                id: mouseArea
                hoverEnabled: true  
                anchors.fill: parent
                onClicked: {
                    if (model.contactId != messenger.getTarget()) {
                        messenger.updateTraget(model.contactId)
                        chat.chatChanged()
                        contactList.selectedIndex = index
                        chat.anyChatIsOpen = true
                        chat.currentLogin = model.contactLogin
                        chat.currentName = model.contactName
                    }
                }
            }

            TemplateButton {
                id: deleteButton
                iconSource: "../resources/icons/close.png"
                visible: isMouseHovered() && messenger.haveAnyMessages() ? 1 : 0
                colorDefault: "transparent"
                width: 15
                height: 15
                iconHeight: 30
                iconWidth: 30
                colorOverlayDefault: "gray"
                colorOverlayClicked: "#d45555"
                anchors {
                    top: parent.top
                    right: parent.right
                    rightMargin: 10
                    topMargin: 15
                }
                onClicked: {
                    contactList.model.remove(index)
                }
            }

            function isMouseHovered() {
                return (mouseArea.containsMouse || deleteButton.hovered)
            }
        }
        
    }

    ListView {
        id: contactList
        property int selectedIndex: -1
        verticalLayoutDirection: ListView.TopToBottom
        model: contactModel
        delegate: contact
        spacing: 0
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            top: search.bottom
            topMargin: 3
        }
        contentWidth: parent.width
        clip: true

        ScrollBar.vertical: ScrollBar {
            id: verticalScrollBar
            policy: ScrollBar.AlwaysOn
            visible: false
        }

        onCountChanged: {
            positionViewAtEnd()
            verticalScrollBar.position = 1
        }
    }
}
