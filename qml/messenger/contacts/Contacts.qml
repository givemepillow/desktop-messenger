import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../../templates"
import "../tools.js" as Tools
import "../"

Rectangle {
    id: root
    property var userIndex: {0: 0}
    Connections {
        target: messenger
        function onDeleteChatSignal() {
            chat.chatChanged()
            Tools.setContacts(search.text)
        }

        function onReloadContacts() {
            Tools.setContacts(search.text)
        }

        function onLoaded() {
            Tools.setContacts(search.text)
        }
    }

    TemplateButton {
        id: nothingIcon
        visible: !search.found && search.text != ''
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
        visible: !search.found && search.text != ''
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
        onTextEdited: Tools.setContacts(text)
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
                root.userIndex[model.contactId] = index
            }

            Rectangle {
                width: parent.width * 0.9
                height: 1
                color: "#636363"
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                visible: index == 0 ? false : true
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
                text: Tools.getMessageTime(messenger.getLastMessageTime(model.contactId))
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
                id: lastMessage
                text: messenger.getLastMessage(model.contactId)
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
                        messenger.markAsRead(model.contactId)
                        readIcon.visible = false
                    }
                }
            }

            TemplateButton {
                id: deleteButton
                iconSource: "../resources/icons/close.png"
                visible: isMouseHovered() && messenger.haveAnyMessages(model.contactId) ? 1 : 0
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
                    openAccept(contactId)
                }
            }

            TemplateButton {
                id: readIcon
                iconSource: "../resources/icons/circle.png"
                enabled: false
                visible: !messenger.isRead(model.contactId)
                colorDefault: "transparent"
                width: 20
                height: 20
                iconHeight: 15
                iconWidth: 15
                colorOverlayDefault: "#184896"
                colorOverlayClicked: "#184896"
                colorOverlayMouseOver: "#184896"
                anchors {
                    left: lastMessage.right
                    leftMargin: 5
                    top: lastMessage.top
                    topMargin: 3
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
        verticalLayoutDirection: ListView.BottomToTop
        model: contactModel
        delegate: contact
        spacing: 0
        height: contentHeight < parent.height ? contentHeight : parent.height
        anchors {
            left: parent.left
            right: parent.right
            top: search.bottom
            topMargin: 3
        }
        contentWidth: parent.width
        clip: true

        function updateContacts() {
            contactModel.clear()
            contactList.selectedIndex = -1
            let users = service.updateContacts()
            // search.found = (users.length == 0) ? false : true
            for (let key in users) {
                let user = users[key]
                contactModel.append({
                    contactName: user[0],
                    contactLogin: user[1],
                    contactId: user[2],
                })
            }
        }

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

    TemplateButton {
        id: astronautIcon
        iconSource: "../resources/icons/astronaut.png"
        colorDefault: "transparent"
        visible: contactList.model.count == 0 && search.text == ''
        width: 60
        height: 60
        iconHeight: 64
        iconWidth: 64
        enabled: false
        colorOverlayDefault: "#b0b0b0"
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: parent.height / 4
        }
    }

    Text {
        text: "Здесь так одиноко..."
        visible: contactList.model.count == 0 && search.text == ''
        color: "#b0b0b0"
        font.pointSize: 12
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: astronautIcon.bottom
            topMargin: 10
        }
    }
}