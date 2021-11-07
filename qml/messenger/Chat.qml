import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import "../templates"

Rectangle {
    id: root
    width: parent.width * 0.7
    color: "#4994ab"
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
        color: container.color
        height: textAreaBlock.height + 20
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        TemplateButton {
            id: sendButton
            colorDefault: "transparent"
            colorOverlayDefault: "#3574d4"
            colorOverlayMouseOver: "#4686e8"
            colorOverlayClicked: "#2b7fff"
            onClicked: console.log('!')
            iconHeight: 36
            iconWidth: 36
            width: 44
            height: 36
            iconSource: "../resources/icons/send.png"
            anchors {
                right: parent.right
                rightMargin: 10
                bottom: parent.bottom
                bottomMargin: ((48 - 36) / 2) + 10
            }
        }

        Rectangle {
            id: textAreaBlock

            height: 48 > scrollV.height ? 48 : scrollV.height
            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                leftMargin: 5
                rightMargin: 5
                left: parent.left
                right: sendButton.left
            }
            color: "transparent"
            border.width: 1
            border.color: "grey"
            radius: 9


            ScrollView {
                id: scrollV

                height:  getHeight(36, 250)

                function getHeight(x, max) {
                    //if (contentHeight < x) return x
                    return contentHeight < max ? contentHeight : max
                }

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 10
                    right: parent.right
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
                    width: parent.width
                    background: Rectangle {
                        color: "transparent"
                    }
                    focusReason: Qt.MouseFocusReason
                    wrapMode: TextEdit.Wrap
                }
            }
        }
    }
    
}