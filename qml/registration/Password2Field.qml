import "../templates"
import "../validator.js" as Validator

PasswordField {
    placeholderText: qsTr("Повторите пароль")
    readOnly: registrationBlock.isOff
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: password1Field.bottom
        topMargin: 25
    }
    onEditingFinished: {
        if (!Validator.equalPasswords(text, password1Field.text) && text !== "") {
            borderColor = warningColor
            warning = "Пароли не совпадаю!"
        }
    }
}            
