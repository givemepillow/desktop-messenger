import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../../templates"


Rectangle {
    color: "#292929"
    height: 45
    Rectangle {
        color: "#3d3d3d"
        height: 1
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
    }
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: 2
        verticalOffset: 3
        color: "#30000000"
    }

    TemplateButton {
        id: onlineIcon
        enabled: false
        width: 14
        height: 14
        iconHeight: 14
        iconSource: "../resources/icons/circle.png"
        colorOverlayDefault: "#d64b4b"
        colorOverlayMouseOver: "#d64b4b"
        colorOverlayClicked: "#d64b4b"
        anchors {
            top: parent.top
            topMargin: 17
            right: parent.right
            rightMargin: 23
        }
    }

    Label {
        id: offlineInfo
        color: "grey"
        text: "не в сети: " + service.getOffline().toString()
        font.pointSize: 12
        Timer {
            interval: 5000; running: true; repeat: true;
            onTriggered: offlineInfo.text =  "не в сети: " + service.getOffline().toString()
        }
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 40
    }

    TemplateButton {
        id: offlineIcon
        enabled: false
        width: 14
        height: 14
        iconHeight: 14
        iconSource: "../resources/icons/circle.png"
        colorOverlayDefault: "#5eba52"
        colorOverlayMouseOver: "#5eba52"
        colorOverlayClicked: "#5eba52"
        anchors {
            top: parent.top
            topMargin: 17
            right: parent.right
            rightMargin: 143
        }
    }

    Label {
        id: onlineInfo
        color: "whitesmoke"
        text: "в сети: " + service.getOnline().toString()
        font.pointSize: 12
        Timer {
            interval: 5000; running: true; repeat: true;
            onTriggered: onlineInfo.text =  "в сети: " + service.getOnline().toString()
        }
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 160
    }

}
