import "../templates"

PasswordField {
    placeholderText: qsTr("Повторите пароль")
    readOnly: registrationBlock.isOff
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: password1Field.bottom
        topMargin: 25
    }
}            
