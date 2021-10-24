import "../templates"
import "../validator.js" as Validator

TemplateField {
    placeholderText: qsTr("Придумайте логин")
    readOnly: registrationBlock.isOff
    maximumLength: 25
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: lastNameField.bottom
        topMargin: 50
    }
    onEditingFinished: {
        if (!Validator.validateLogin(text) && text !== "") {
            borderColor = warningColor
            warning = "Некорректный логин!"
        } else if (!Validator.lengthLogin(text) && text !== "") {
            borderColor = warningColor
            warning = "Минимальная длина логина - 3 символа!"
        }
    }
}
