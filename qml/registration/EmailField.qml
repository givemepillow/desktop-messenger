import "../templates"
import "../validator.js" as Validator

TemplateField {
    placeholderText: qsTr("Введите email")
    readOnly: registrationBlock.isOff
    maximumLength: 50
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: loginField.bottom
        topMargin: 25
    }
    onEditingFinished: {
        if (!Validator.validateEmail(text) && text !== "") {
            borderColor = warningColor
            warning = "Некорректный адрес электронной почты!"
        }
    }
}