import QtQuick
import QtQuick.Window
import QtQuick.Controls
import "../templates"

TemplateField {
    
    property color bgColor: "#3e3e3e"
    font.pixelSize: 22
    height: 50
    width: 200
    maximumLength: 6
    horizontalAlignment: TextInput.AlignHCenter
    inputMethodHints: Qt.ImhDigitsOnly
    validator: IntValidator {bottom: 0; top: 999999}
    echoMode: TextInput.PasswordEchoOnEdit
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: parent.height / 2
    }
    background: Rectangle {
        anchors.fill: parent
        color: "transparent"
    }
}
