import QtQuick
import QtQuick.Window
import QtQuick.Controls
import "../templates"

Rectangle {
    id: popup
    height: 45
    color: "#732a2a"
    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
    }
    visible: false
    property string text_info: qsTr("Ошибка на стороне сервера!")
    Label {
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        text: popup.text_info
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.weight: Font.Medium
        font.pointSize: 9
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
            iconSource: "../../resources/icons/close.png"
            width: parent.width
            height: parent.height
            colorClicked: "transparent"
            colorOverlayMouseOver: "#9e9e9e"
            colorOverlayClicked: "#ffffff"
            colorOverlayDefault: "#707070"
            onClicked: {
                popup.visible = false
            }
        }
    } 
} 
