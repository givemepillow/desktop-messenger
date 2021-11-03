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
    
    function isValid() {
        if (!Validator.isEnoughLoginLength(text))
            return false
        else if (!Validator.isValidLogin(text))
            return false
        else
            return true
    }

    onEditingFinished: {
        if (!Validator.isValidLogin(text) && text !== "") {
            borderColor = warningColor
            warning = "Некорректный логин!"
        } else if (!Validator.isEnoughLoginLength(text) && text !== "") {
            borderColor = warningColor
            warning = "Минимальная длина логина - 3 символа!"
        }
    }
    onTextEdited: {
        if (isValid()) {
            if (!service.availableLogin(text)) {
                if (service.isError()) {
                    container.errorBarTextInfo = service.getServerMessage()
                    container.errorBarVisible = true
                } else {
                    warning = service.getServerMessage()
                    container.errorBarVisible = false
                }
            } else {
                container.errorBarVisible = false
                tip = service.getServerMessage()
            }
        }
    }
}
