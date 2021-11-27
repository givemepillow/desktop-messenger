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
                if (service.isError()) {
                    container.errorBarTextInfo = service.getServerMessage()
                    container.errorBarVisible = true
                } else {
                    container.errorBarVisible = false
                    warning = service.getServerMessage()
                }
            } else {
                container.errorBarVisible = false
                tip = service.getServerMessage()
            }
        }
    }
}