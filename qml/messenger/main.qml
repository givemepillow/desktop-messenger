import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material
import "../templates"
import "chat"
import "contacts"
import "bar"
import Messenger

TemplateWindow {
    id: window
    windowHeigth: 720
    windowWidht: 980

    TitleBar {
        id: titleBar
        title: "Desktop messenger."
    }

    Container {
        id: container

        color: "#2b2b2b"

        Dialog {
            id: dialog
            Material.theme: Material.Dark
            visible: false
            Label {
                text: "Вы действительно хотите безвозвратно\nудалить переписку?"
                color: "whitesmoke"
                font.pointSize: 12
                height: contentHeight
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
            }
            modal: false
            width: 400
            height: 150

            property string acceptText: "Да, удалить."
            property string rejectText: "Отмена."
            
            anchors.centerIn: parent

            property int chatIndex: -1
            property int contactId: -1
            
            Row {
                anchors.bottom: parent.bottom
                spacing: 10
                Button {
                    font.pointSize: 12
                    background: Rectangle {
                        anchors.fill: parent
                        color: Material.color(Material.Red) 
                    }
                    height: 40
                    width: dialog.width / 2 - 30
                    text: dialog.acceptText
                    onClicked:{
                       console.log(dialog.contactId)
                       messenger.deleteChat(dialog.contactId)
                       dialog.visible = false
                    }
                }
                Button {
                    font.pointSize: 12
                    background: Rectangle {
                        anchors.fill: parent
                        color: Material.color(Material.Green) 
                    }
                    height: 40
                    width: dialog.width / 2 - 30
                    text: dialog.rejectText
                    onClicked: dialog.visible = false
                }
            }
        }

        Messenger {
            id: messenger
        }


        Chat {
            id: chat

            width: parent.width * 0.7
            color: "transparent"

            anchors {
                right: parent.right
                top: bar.bottom
                bottom: parent.bottom
            }
        }

        Contacts {
            id: contacts

            signal openAccept(int contactId)
            onOpenAccept: {
                dialog.visible = true
                dialog.contactId = contactId
            }

            color: "transparent"

            anchors {
                left: parent.left
                top: bar.bottom
                bottom: parent.bottom
                right: chat.left
                rightMargin: 0
            }

        }

        Rectangle {
            anchors {
                right: contacts.right
                top: bar.bottom
                bottom: parent.bottom
            }
            width: 1
            color: "#2b2b2b"
            layer.enabled: true
            layer.effect: DropShadow {
                spread: 0.0
                transparentBorder: true
                horizontalOffset: 1
                verticalOffset: 0
                color: "#90000000"
            }
        }

        Bar {
            id: bar
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }
        }
    }
}