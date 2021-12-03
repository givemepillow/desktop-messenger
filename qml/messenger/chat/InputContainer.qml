import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../../templates"
import "../tools.js" as Tools

Rectangle {
    id: inputContainer
    color: "transparent"
    height: textAreaBlock.height + 20
    anchors {
        bottom: parent.bottom
        left: parent.left
        right: parent.right
    }

    TemplateButton {
        id: sendButton
        colorDefault: "transparent"
        colorOverlayDefault: textArea.length == 0 ? "grey" : "#8373d1"
        colorOverlayMouseOver: textArea.length == 0 ? "grey" : "#8660e6"
        colorOverlayClicked: textArea.length == 0 ? "grey" : "#7048d4"
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
        onClicked: Tools.send()
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
        color: "#333333"
        border.width: 1
        border.color: "grey"
        radius: 9


        ScrollView {
            id: scrollV

            height: contentHeight < 250 ? contentHeight : 250

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 10
                right: parent.right
            }

            ScrollBar.vertical {
                policy: ScrollBar.AlwaysOn
                visible: false
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
                onTextChanged: {
                    if (length > 1000) {
                        remove(1000, length)
                    }
                }

                Keys.onReturnPressed: (event)=> {
                    if (!(event.modifiers & Qt.ShiftModifier) && !(event.modifiers & Qt.ControlModifier))
                        Tools.send()
                    else
                        insert(length, '\n')
                }
            }
        }
    }
}