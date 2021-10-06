import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

TemplateField {
    placeholderText: qsTr("Введите пароль")
    echoMode: TextInput.Password
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: emailField.bottom
        topMargin: 50
    }
}            
