import "../components"
import "../validator.js" as Validator

PasswordField {
    placeholderText: qsTr("Повторите пароль")
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: password1Field.bottom
        topMargin: 25
    }
    onEditingFinished: {
        if (!Validator.equalPasswords(text, password1Field.text) && text !== "") {
            borderColor = warningColor
            warning = "Пароли не совпадают!"
        }
    }
    onTextEdited: {
        if (password1Field.isValid() && Validator.equalPasswords(text, password1Field.text))
            tip = "Пароли совпадают."
    }
}            
