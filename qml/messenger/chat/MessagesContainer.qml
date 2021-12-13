import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../../templates"
import "../tools.js" as Tools


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
        height: 100
        color: "#40000000"
        visible: messageList.count == 0
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            topMargin: 70
        }
        Text {
            font.pointSize: 20
            color: "whitesmoke"
            text: "Нет ни одного сообщения -\nнапишите что-нибудь :)"
            anchors.centerIn: parent
            style: Text.Raised; styleColor: "gray"
            horizontalAlignment: Text.AlignHCenter
        }
    }

    

    signal chatChanged()
    onChatChanged: {
        messageModel.clear()
        chatBar.chatChanged()
        let messages = messenger.loadMessages()
        for (let i in messages) {
            messageModel.append({
                "messageId": messages[i][0],
                "fromId": messages[i][1],
                "toId": messages[i][2],
                "messageText": messages[i][3],
                "messageTime": messages[i][4]
            })
            messageList.positionViewAtEnd()
        }
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
                    "messageTime": dateTime,
                    "messageId": messageId
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
                width: messageArea.width < (messageDate.width + 45) ? messageDate.width + 45: messageArea.width
                Component.onCompleted: if (model.fromId == service.getMyId()) anchors.right = parent.right

                MouseArea {
                    id: mouseArea
                    hoverEnabled: true  
                    anchors.fill: parent
                }

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


                Text {
                    id: messageDate
                    text: Tools.getMessageTime(model.messageTime)
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

                TemplateButton {
                    id: deleteButton
                    iconSource: "../resources/icons/trash.png"
                    iconHeight: 20
                    iconWidth: 20
                    colorOverlayDefault: "#787878"
                    colorOverlayMouseOver: "#733c3f"
                    colorOverlayClicked: "#c9222d"
                    visible: (mouseArea.containsMouse || deleteButton.hovered) && model.fromId == service.getMyId() 
                    height: 20
                    width: 20
                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                        leftMargin: 5
                        bottomMargin: 5
                    }
                    onClicked: messenger.deleteMessage(model.messageId)
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
                positionViewAtStart()
                verticalScrollBar.position = 0
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

    ChatBar {
        id: chatBar
    }
}