import QtQuick
import QtQuick.Window
import QtQuick.Controls

PasswordField {
    placeholderText: qsTr("Введите пароль")
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: emailField.bottom
        topMargin: 50
    }
}            
