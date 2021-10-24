import QtQuick
import QtQuick.Window
import QtQuick.Controls

TemplateField {
    echoMode: showPassword.pressed ? TextInput.Normal : TextInput.Password
    inputMethodHints: Qt.ImhSensitiveData | Qt.ImhHiddenText
    Rectangle {
        width: 30
        color: "transparent"
        anchors {
            right: parent.right
            bottom: parent.bottom
            top: parent.top
            rightMargin: 10
        }
        TemplateButton {
            id: showPassword
            iconSource: showPassword.pressed ? "../resources/icons/show_pass.png" : "../resources/icons/hide_pass.png"
            iconHeight: parent.height - 5
            iconWidth: parent.width - 5
            height: parent.height
            width: parent.width
        }
    }
}  