import "../components"
import "../validator.js" as Validator

PasswordField {
    placeholderText: qsTr("Введите пароль")
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: 150
    }

    function isValid() {
        if ((!Validator.isEnoughPasswordLength(text)) || (!Validator.isValidPassword(text)))
            return false
        else
            return true
    }

    onEditingFinished: {
        if (!Validator.isValidPassword(text) && text !== "") {
            borderColor = warningColor
            warning = "Некорректный пароль!"
        } else if (!Validator.isHardPassword(text) && text !== "") {
            borderColor = warningColor
            warning = "Слабый пароль!"
        } else if (!Validator.isEnoughPasswordLength(text) && text !== "") {
            borderColor = warningColor
            warning = "Минимальная длина пароля - 8 символов!"
        } else {
            password2Field.editingFinished()
        }
    }
    onTextEdited: {
        if (Validator.equalPasswords(text, password2Field.text)) {
            password2Field.warning = ""
            password2Field.borderColor = password2Field.defaultborderColor
        } 
        if (isValid() && Validator.isHardPassword(text)) tip = "Сильный пароль!"
    }
}            
