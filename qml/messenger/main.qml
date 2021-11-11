import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../templates"
import "chat"
import "contacts"
import "bar"

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