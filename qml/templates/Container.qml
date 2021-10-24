import QtQuick
import QtQuick.Window
import QtQuick.Controls

Rectangle {
    id: container
    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
        top: titleBar.bottom
    }
    color: "#3d3d3d"
    Rectangle {
        id: errorBar
        height: 45
        z: 10
        color: "#732a2a"
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        visible: false
        property string textInfo: qsTr("Ошибка на стороне сервера!")
        Label {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text: parent.textInfo
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.Medium
            font.pointSize: 10
            font.family: "Arial"
            color: "white"
        }
        Rectangle {
            width: 20
            height: 20
            color: "transparent"
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            TemplateButton {
                iconSource: "../resources/icons/close.png"
                width: parent.width
                height: parent.height
                iconHeight: 30
                colorClicked: "transparent"
                colorOverlayMouseOver: "#9e9e9e"
                colorOverlayClicked: "#ffffff"
                colorOverlayDefault: "#707070"
                onClicked: {
                    errorBar.visible = false
                }
            }
        } 
    } 
}