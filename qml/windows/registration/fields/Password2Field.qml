import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

TemplateField {
    placeholderText: qsTr("Повторите пароль")
    echoMode: TextInput.Password
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: password1Field.bottom
        topMargin: 25
    }
}            
