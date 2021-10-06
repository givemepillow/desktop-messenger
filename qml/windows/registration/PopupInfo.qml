import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "../../templates"

Popup {
    id: popup
    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 400
    height: 200
    modal: true
    focus: true
    background: Rectangle {
        anchors.fill: parent
        color: "#3d3d3d"
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 70
            text: qsTr("Ошибка на стороне сервера!")
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.Medium
            font.pointSize: 13
            font.family: "Arial"
            color: "white"
        }
        Rectangle {
            width: 100
            height: 30
            color: "#20437a"
            anchors {
                bottom: parent.bottom
                bottomMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
            TextButton {
                buttonText: qsTr("OK")
                width: parent.width
                height: parent.height
                colorDefaultText: "white"
                colorClicked: "#3e6fbd"
                colorMouseOver: "#0e1e36"
                onClicked: {
                    popup.close()
                }
            }
        }
        
    }
    
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
} 