import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "../../../templates"

TemplateField {
    placeholderText: qsTr("Повторите пароль")
    echoMode: showPassword.pressed ? TextInput.Normal : TextInput.Password
    inputMethodHints: Qt.ImhSensitiveData | Qt.ImhHiddenText
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: password1Field.bottom
        topMargin: 25
    }
    Rectangle {
        width: 30
        color: "transparent"
        anchors {
            right: parent.right
            bottom: parent.bottom
            top: parent.top
            rightMargin: 10
        }
        IconButton {
            id: showPassword
            iconSource: showPassword.pressed ? "../../../resources/icons/show_pass.png" : "../../../resources/icons/hide_pass.png"
            iconHeight: parent.height - 5 ; iconWidth: parent.width - 5
            height: parent.height; width: parent.width
            colorMouseOver: "transparent"
            colorClicked: "transparent"
            colorOverlayDefault: "gray"
        }
    }
}            
