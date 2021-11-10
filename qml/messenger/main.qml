import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import "../templates"

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

        Contacts {
            id: contacts

            color: "lightgreen"
            
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                right: chat.left
            }
        }

        Chat {
            id: chat

            width: parent.width * 0.7
            color: "transparent"

            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
        }
    }
}