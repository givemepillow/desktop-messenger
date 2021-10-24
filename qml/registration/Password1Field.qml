import "../templates"
import "../validator.js" as Validator

PasswordField {
    placeholderText: qsTr("Введите пароль")
    readOnly: registrationBlock.isOff
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: emailField.bottom
        topMargin: 50
    }
    onEditingFinished: {
        if (!Validator.validatePassword(text) && text !== "") {
            borderColor = warningColor
            warning = "Некорректный пароль!"
        } else if (!Validator.isHardPassword(text) && text !== "") {
            borderColor = warningColor
            warning = "Слабый пароль!"
        } else if (!Validator.lengthPassword(text) && text !== "") {
            borderColor = warningColor
            warning = "Минимальная длина пароля - 8 символов!"
        } else {
            password2Field.editingFinished()
        }
    }
}            
