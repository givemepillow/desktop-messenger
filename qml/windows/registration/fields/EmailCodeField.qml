import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "../../../templates"

TemplateField {
    placeholderText: qsTr("Код")
    property color bgColor: "#3e3e3e"
    font.pointSize: 13
    height: 50
    width: 200
    maximumLength: 6
    horizontalAlignment: TextInput.AlignHCenter
    inputMethodHints: Qt.ImhDigitsOnly
    validator: IntValidator {bottom: 0; top: 999999}
    echoMode: TextInput.PasswordEchoOnEdit
    rightInset: 0
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: parent.height / 2
    }
}
