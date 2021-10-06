import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15


TextField {
    id: password1Field
    width: 300
    height: 40
    property color bgColor: "#37000000"
    echoMode: TextInput.Password
    text: qsTr("")
    color: "white"
    selectByMouse: true
    placeholderText: qsTr("Введите пароль")
    verticalAlignment: Text.AlignVCenter
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: emailField.bottom
        topMargin: 50
    }
    font.pointSize: 10
    background: Rectangle {
        anchors.fill: parent
        color: bgColor
        radius: 6
    }
    onPressed: {
        bgColor = "#37000000"
    }
}            
