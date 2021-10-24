import "../templates"

PasswordField {
    placeholderText: qsTr("Введите пароль")
    readOnly: registrationBlock.isOff
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: emailField.bottom
        topMargin: 50
    }
}            
