import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../../templates"

Rectangle {
    id: root

    ListModel {
        id: contactModel

        ListElement {
            contactName: "Kirill"
            lastMessage: "hello!"
            lastMessageTime: "12:00"
            contactLogin: "kirillka"
            
        }

        ListElement {
            contactName: "Kirill Lapushinskiy"
            lastMessage: "hello! how are u?"
            lastMessageTime: "12:00"
            contactLogin: "kirilllapushinskiy"
        }

    }

    Component {
        id: contact
        
        Rectangle {
            id: contactBlock
             
            color:  isMouseHovered() ? "#3d3d3d" :"#333333"
            height: 70
            width: root.width

            Text {
                id: contactName
                text: model.contactName
                color: "whitesmoke"
                font.pointSize: 11
                visible: !isMouseHovered()
                anchors {
                    top: parent.top
                    left: parent.left
                    leftMargin: 10
                    topMargin: 10
                }
            }

            Text {
                text: model.contactLogin
                color: "#af8cde"
                font.pointSize: 11
                visible: isMouseHovered()
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
            }

            TemplateButton {
                id: deleteButton
                iconSource: "../resources/icons/close.png"
                opacity: isMouseHovered() ? 1 : 0
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
            }

            function isMouseHovered() {
                return (mouseArea.containsMouse || deleteButton.hovered)
            }
        }
        
    }

    ListView {
        id: contactList
        verticalLayoutDirection: ListView.TopToBottom
        model: contactModel
        delegate: contact
        spacing: 0
        anchors.fill: parent
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
