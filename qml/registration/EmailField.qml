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
    function isValid() {
        if (!Validator.isValidEmail(text))
            return false
        return true
    }

    onEditingFinished: {
        if (!Validator.isValidEmail(text) && text !== "") {
            borderColor = warningColor
            warning = "Некорректный адрес электронной почты!"
        }
    }
    onTextEdited: {
        if (isValid()) {
            if (!service.availableEmail(text)) {
                warning = service.getServerMessage()
            } else {
                tip = service.getServerMessage()
            }
        }
    }
}