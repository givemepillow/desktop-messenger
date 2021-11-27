function isValidLoginOrEmail(field) {
    let length = Validator.isEnoughLoginLength(field.text)
    let validEmail = Validator.isValidEmail(field.text)
    let validLogin = Validator.isValidLogin(field.text)
    let valid = false
    if ((!length || (!validEmail && !validLogin))) {
        field.borderColor = field.warningColor
        field.warning = "Некорректный логин или email!"
    } else {
        // For login.
        if (!Validator.isValidEmail(field.text)) {
            if (service.availableLogin(field.text)) {
                field.warning = "Данный логин не зарегистрирован."
            } else {
                if (service.isError()) {
                    container.errorBarTextInfo = service.getServerMessage()
                    container.errorBarVisible = true
                } else {
                    container.errorBarVisible = false
                    valid = true
                }
            }
        } else {
            // For email.
            if (service.availableEmail(field.text)) {
                field.warning = "Данный email не зарегистрирован."
            } else {
                if (service.isError()) {
                    container.errorBarTextInfo = service.getServerMessage()
                    container.errorBarVisible = true
                } else {
                    container.errorBarVisible = false
                    valid = true
                }
            }
        }
    }
    return valid
}


function verifyCode() {
    let valid = false
    if (Validator.isValidEmail(loginOrEmailBlock.loginOrEmail))
        valid = service.recoveryCodeVerification(loginOrEmailBlock.loginOrEmail, null, codeVerificationField.text)
    else
        valid = service.recoveryCodeVerification(null, loginOrEmailBlock.loginOrEmail, codeVerificationField.text)
    if (valid) {
        codeVerificationBlock.visible = false
        newPasswordBlock.visible = true
        container.errorBarVisible = false
    } else {
        if (service.isError()) {
            container.errorBarTextInfo = service.getServerMessage()
            container.errorBarVisible = true
        } else {
            container.errorBarVisible = false
            codeVerificationField.warning = service.getServerMessage()
        }
    }
}

function setNewPassword() {
    let result = false
    let fileds = [password1Field, password2Field]
    if (Validator.isAllValid(fileds)) {
        if (Validator.isValidEmail(loginOrEmailBlock.loginOrEmail))
            result = service.newPassword(loginOrEmailBlock.loginOrEmail, null, password1Field.text)
        else
            result = service.newPassword(null, loginOrEmailBlock.loginOrEmail, password1Field.text)
        if (result) {
            newPasswordBlock.visible= false
            completeBlock.visible = true
            completeBlock.focus = true
            container.errorBarVisible = false
        } else {
            container.errorBarTextInfo = service.getServerMessage()
            container.errorBarVisible = true
        }
    }
}

function sendCode() {
    if (isValidLoginOrEmail(loginOrEmailField)) {
        loginOrEmail = loginOrEmailField.text
        if (Validator.isValidEmail(loginOrEmail)) {
            if (service.recoveryEmailVerification(loginOrEmail, null)) {
                codeVerificationBlock.visible = true
                loginOrEmailBlock.visible = false
            }
        } else {
            if (service.recoveryEmailVerification(null, loginOrEmail, )) {
                codeVerificationBlock.visible = true
                loginOrEmailBlock.visible = false
            }
        }
    }
}