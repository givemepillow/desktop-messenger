import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../../templates"


Rectangle {
    id: messagesContainer
    color: "transparent"
    anchors {
        top: parent.top
        bottom: inputContainer.top
        left: parent.left
        right: parent.right
    }
    Rectangle {
        property ListModel model: messageModel
        color: "transparent"
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            leftMargin: 10
            rightMargin: 10
        }


        Connections {
            target: messenger
            function onNewMessage(fromId, toId, message, dateTime, messageId) {
                messageModel.append({
                    "fromId": fromId,
                    "toId": toId,
                    "messageText": message,
                    "messageTime": dateTime
                })
            }
        }

        ListModel {
            id: messageModel
        }

        Component {
            id: message
            
            Rectangle {
                id: messageBlock

                readonly property int maxWidth: 500

                layer.enabled: true
                layer.effect: DropShadow {
                    spread: 0.0
                    transparentBorder: true
                    horizontalOffset: 2
                    verticalOffset: 4
                    color: "#20000000"
                }
                
                color: "#333333"
                radius: 6
                height: messageArea.height + 30
                width: messageArea.width < 55 ? 55 : messageArea.width
                Component.onCompleted: if (model.fromId == service.getMyId()) anchors.right = parent.right

                TextEdit {
                    id: messageArea
                    readOnly: true
                    selectByMouse: true
                    color: "white"
                    font.pixelSize: 18
                    text: model.messageText
                    wrapMode: TextEdit.Wrap
                    leftPadding: 10
                    rightPadding: 10
                    topPadding: 5
                    selectionColor: "grey" 
                    anchors {
                        right: parent.right
                        top: parent.top
                    }
                    Component.onCompleted: {
                        if (messageArea.contentWidth > maxWidth) {
                            messageArea.width = maxWidth
                        }
                    }
                }

                function getTime(timestamp) {
                    var date = new Date(timestamp)
                    return date.getHours()+":"+date.getMinutes()
                }

                Text {
                    text: getTime(model.messageTime)
                    color: "#787878"
                    font.pointSize: 11
                    anchors {
                        top: messageArea.bottom
                        bottom: parent.bottom
                        right: parent.right
                        rightMargin: 10
                        bottomMargin: 5
                    }
                }
            }
            
        }

        ListView {
            id: messageList
            verticalLayoutDirection: ListView.TopToBottom
            model: messageModel
            delegate: message
            spacing: 7
            height: contentHeight < parent.height ? contentHeight : parent.height
            width: parent.white
            contentWidth: parent.width
            clip: true
            cacheBuffer: 2000

            footerPositioning: ListView.InlineFooter

            footer: Rectangle {
                width: messageList.width
                height: 25
                color: "transparent"
            }

            headerPositioning: ListView.InlineFooter

            header: Rectangle {
                width: messageList.width
                height: messagesContainer.height / 3
                color: "transparent"
            }

            anchors {
                bottom: parent.bottom
                bottomMargin: 0
                left: parent.left
                right: parent.right

            }

            ScrollBar.vertical: ScrollBar {
                id: verticalScrollBar
                policy: ScrollBar.AlwaysOn
                visible: false
            }

            onCountChanged: {
                positionViewAtEnd()
                verticalScrollBar.position = 1
                downButton.visible = false
            }

            onMovementStarted: {
                if (verticalScrollBar.position > (1 - 13/count))
                    downButton.visible = false
                else
                    downButton.visible = true
            }

            onMovementEnded: {
                if (verticalScrollBar.position < (1 - 13/count))
                    downButton.visible = true
                else
                    downButton.visible = false
            }

        }

            
        TemplateButton {
            id: downButton
            visible: false
            colorDefault: "transparent"
            colorOverlayDefault: "#a38dba"
            colorOverlayMouseOver: "#9172b5"
            colorOverlayClicked: "#9d58ed"
            iconHeight: 40
            iconWidth: 40
            width: 50
            height: 50
            iconSource: "../resources/icons/down.png"
            anchors {
                bottom: parent.bottom
                right: parent.right
                bottomMargin: 25
            }
            onClicked: {
                messageList.positionViewAtEnd()
                downButton.visible = false
            }
        }
    }

    ChatBar {}
}