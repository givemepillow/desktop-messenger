import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15


TextField {
    id: passwordField
    width: 300
    height: 40
    echoMode: TextInput.Password
    text: qsTr("")
    color: "white"
    selectByMouse: true
    placeholderText: qsTr("Введите пароль")
    verticalAlignment: Text.AlignVCenter
    anchors.horizontalCenter: parent.horizontalCenter
    leftPadding: 15
    anchors.topMargin: 25
    font.pointSize: 10
    background: Rectangle {
        anchors.fill: parent
        color: "#37000000"
        radius: 20
    }
}            
