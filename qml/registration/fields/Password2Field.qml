import QtQuick
import QtQuick.Window
import QtQuick.Controls

PasswordField {
    placeholderText: qsTr("Повторите пароль")
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: password1Field.bottom
        topMargin: 25
    }
}            
