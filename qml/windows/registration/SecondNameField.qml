import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15


TextField {
    id: secondNameField
    property color bgColor: "#37000000"
    width: 300
    height: 40
    text: qsTr("")
    color: "white"
    selectByMouse: true
    placeholderText: qsTr("Введите фамилию")
    verticalAlignment: Text.AlignVCenter
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: firstNameField.bottom
        topMargin: 10
    }
    font.pointSize: 10
    rightInset: 4
    background: Rectangle {
        anchors.fill: parent
        color: bgColor
        radius: 6
    }
}
