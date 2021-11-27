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

    Rectangle {
        id: loginBlock
        color: "transparent"
        height: parent.height
        width: myLogin.width
        Text {
            id: myLogin
            text: service.getMyLogin()
            color: "grey"
            font.pointSize: 14
            anchors {
                right: parent.right
                rightMargin: 0
                verticalCenter: parent.verticalCenter
            }
        }
        anchors {
            right: parent.right
            rightMargin: 50
            verticalCenter: parent.verticalCenter
        }
    }

    TemplateButton {
        id: exitIcon
        width: 25
        height: 25
        iconHeight: 25
        iconSource: "../resources/icons/exit.png"
        colorOverlayDefault: "grey"
        colorOverlayMouseOver: "whitesmoke"
        colorOverlayClicked: "white"
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 10
        }
        onClicked: {
            windowManager.openLoginWindow()
            service.logout()
        }
    }

    Rectangle {
        id: nameBlock
        anchors {
            right: loginBlock.left
            rightMargin: 10
            verticalCenter: parent.verticalCenter
        }
        color: "transparent"
        height: parent.height
        width: myFirstName.width + myLastName.width
        MouseArea {
            id: mouseArea
            hoverEnabled: true  
            anchors.fill: parent
        }
        Text {
            id: myFirstName
            text: service.getMyFirstName()
            color: "#bdbdbd"
            font.pointSize: 14
            anchors {
                right: myLastName.left
                rightMargin: 7
                verticalCenter: parent.verticalCenter
            }
        }
        Text {
            id: myLastName
            text: service.getMyLastName()
            color: "#bdbdbd"
            font.pointSize: 14
            anchors {
                right: parent.right
                rightMargin: 0
                verticalCenter: parent.verticalCenter
            }
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
        anchors.left: onlineIcon.right
        anchors.leftMargin: 15
    }

    TemplateButton {
        id: offlineIcon
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
            left: offlineInfo.right
            leftMargin: 7
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
        anchors.left: parent.left
        anchors.leftMargin: 15
    }


    TemplateButton {
        id: onlineIcon
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
            left: onlineInfo.right
            leftMargin: 7
        }
    }

}
