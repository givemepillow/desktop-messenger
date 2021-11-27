import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../../templates"
import "tools.js" as Tools


Rectangle {
    color: "#292929"
    height: 40

    signal chatChanged()
    onChatChanged: onlineStatus.updateTime()

    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
    }
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: 2
        verticalOffset: 3
        color: "#30000000"
    }
    Text {
        id: name
        text: root.currentName
        color: "whitesmoke"
        font.pointSize: 12
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 20
        }
    }

    Text {
        text: root.currentLogin
        color: "#969696"
        font.pointSize: 12
        anchors {
            verticalCenter: parent.verticalCenter
            left: name.right
            leftMargin: 10
        }
    }

    Text {
        id: onlineStatus
        text: "vnfnec"
        color: "#c186fc"
        font.pointSize: 12
        anchors {
            verticalCenter: parent.verticalCenter
            right: statusIcon.left
            rightMargin: 7
        }
        Timer {
            interval: 5000; running: true; repeat: true;
            onTriggered: onlineStatus.updateTime()
        }
        function updateTime() {
            let status = service.getUserOnlineStatus(messenger.getTarget())
            if (status == 0) {
                onlineStatus.text = "в сети"
                onlineStatus.color = 'whitesmoke'
                statusIcon.btnColor = '#5eba52'
            } else if (status == -1){
                onlineStatus.text = "никогда"
                onlineStatus.color = 'gray'
                statusIcon.btnColor = 'gray'
            } else {
                onlineStatus.text = "последний раз был/была в сети " + Tools.getUserTime(status)
                onlineStatus.color = 'gray'
                statusIcon.btnColor = 'gray'
            }
        }
    }

    TemplateButton {
        id: statusIcon
        enabled: false
        property color btnColor: "gray"
        width: 14
        height: 14
        iconHeight: 14
        iconWidth: 14
        iconSource: "../resources/icons/circle.png"
        colorOverlayDefault: btnColor
        colorOverlayMouseOver: btnColor
        colorOverlayClicked: btnColor
        anchors {
            top: parent.top
            topMargin: 15
            right: parent.right
            rightMargin: 10
        }
    }
}
