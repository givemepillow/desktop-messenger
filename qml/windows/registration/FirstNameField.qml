import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15


TextField {
    id: firstNameField
    property color bgColor: "#37000000"
    width: 300
    height: 40
    text: qsTr("")
    color: "white"
    selectByMouse: true
    placeholderText: qsTr("Введите имя")
    verticalAlignment: Text.AlignVCenter
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: 100
    }
    font.pointSize: 10
    rightInset: 4
    background: Rectangle {
        anchors.fill: parent
        color: bgColor
        radius: 6
    }
    onPressed: {
        bgColor = "#37000000"
    }
}
