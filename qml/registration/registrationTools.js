function registration() {
    let fields = [
        firstNameField, lastNameField,
        loginField, emailField,
        password1Field, password2Field
    ]
    if (!Validator.isEmpty(fields) && Validator.isAllValid(fields)) {
        if (service.emailVerification(emailField.text, loginField.text, )) {
            registrationBlock.isOff = true
            container.errorBarVisible = false
        } else {
            container.errorBarTextInfo = service.getServerMessage()
            container.errorBarVisible = true
            registrationBlock.isOff = false
        }
    }
}

function acceptCode() {
    if (service.codeVerification(emailField.text, codeField.text)) {
        if (service.registration(
            loginField.text,
            emailField.text,
            password1Field.text,
            firstNameField.text,
            lastNameField.text
        )) {
            registrationBlock.isOff = false
            registrationCompleteBlock.visible = true
        }
    } else {
        if (service.isError()) {
            container.errorBarTextInfo = service.getServerMessage()
            container.errorBarVisible = true
            registrationBlock.isOff = false
        } else {
            codeLabel.text = service.getServerMessage()
            codeLabel.color = codeLabel.warningColor
            codeLabel.font.pointSize = 16
            codeField.focus = true
            codeField.text = ""
        }
    }
}