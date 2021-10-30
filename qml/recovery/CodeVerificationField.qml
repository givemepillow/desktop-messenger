import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
import "../templates"

TemplateField {
    id: codeVerificationField
    font.pixelSize: 20
    height: 40
    width: 180
    maximumLength: 6
    inputMethodHints: Qt.ImhDigitsOnly
    horizontalAlignment: TextInput.AlignHCenter
    validator: IntValidator {bottom: 0; top: 999999}
    echoMode: TextInput.PasswordEchoOnEdit
    anchors {
        top: parent.top
        topMargin: 200
        horizontalCenter: parent.horizontalCenter
    }
}