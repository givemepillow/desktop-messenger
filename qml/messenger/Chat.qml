import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import "../templates"

Rectangle {
    id: root
    width: parent.width * 0.7
    color: "#304361"
    anchors {
        right: parent.right
        top: parent.top
        bottom: parent.bottom
    }
    /* Flickable {
        id: flickable
        clip: true
        width: parent.width
        height: contentHeight < 150 ?  contentHeight : 150
        anchors {
            bottom: parent.bottom
            left: parent.left
        }
        TextArea {
            placeholderText: qsTr("Напишите сообщение...")
            width: parent.width
        }
        ScrollBar.vertical: ScrollBar {
            parent: flickable.parent
            anchors.top: flickable.top
            anchors.left: flickable.right
            anchors.bottom: flickable.bottom
        }
    } */

    Rectangle {
        id: inputContainer
        color: "transparent"
        height: scrollV.height
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            bottomMargin: 10
            leftMargin: 10
            rightMargin: 10
        }

        TemplateButton {
            id: sendButton
            colorMouseOver: "#616161"
            colorClicked: "#ba3b32"
            onClicked: console.log('!')
            iconHeight: 36
            iconWidth: 36
            width: 44
            height: 36
            iconSource: "../resources/icons/send.png"
            anchors {
                right: parent.right
                bottom: parent.bottom
            }
        }

        ScrollView {
            id: scrollV

            height:  getHeight(36, 150)

            function getHeight(x, max) {
                //if (contentHeight < x) return x
                return contentHeight < max ? contentHeight : max
            }

            anchors {
                bottom: parent.bottom
                left: parent.left
                right: sendButton.left
            }

            ScrollBar.vertical {
                policy: ScrollBar.AlwaysOff
            }
            TextArea {
                id: textArea
                placeholderText: qsTr("Напишите сообщение...")
                color: "white"
                font.pixelSize: 18
                selectByMouse: true
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }
            }
        }
    }
    
}