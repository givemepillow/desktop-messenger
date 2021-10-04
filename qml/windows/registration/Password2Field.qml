import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15


TextField {
    id: password2Field
    width: 300
    height: 40
    property color bgColor: "#37000000"
    echoMode: TextInput.Password
    text: qsTr("")
    color: "white"
    selectByMouse: true
    placeholderText: qsTr("Повторите пароль")
    verticalAlignment: Text.AlignVCenter
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: password1Field.bottom
        topMargin: 10
    }
    font.pointSize: 10
    background: Rectangle {
        anchors.fill: parent
        color: bgColor
        radius: 6
    }
}            
