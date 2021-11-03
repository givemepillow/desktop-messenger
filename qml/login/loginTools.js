// login //
function $isValidLogin(login) {
    let length = Validator.isEnoughLoginLength(login)
    let validEmail = Validator.isValidEmail(login)
    let validLogin = Validator.isValidLogin(login)
    if ((!length || (!validEmail && !validLogin)) && login !== "")
        return false
    return true
}

function onEditingFinishedEmailOrLogin() {
    if (!$isValidLogin(loginField.text)) {
        loginField.borderColor = loginField.warningColor
        loginField.warning = "Некорректный логин или email!"
    }
}

function onTextEditedEmailOrLogin() {
    if ($isValidPassowrd(passwordField.password)) {
        passwordField.borderColor = passwordField.defaultborderColor
    }
}

// password //
function $isValidPassowrd(password) {
    if (password == "") return true
    if (!Validator.isValidPassword(password)) return false
    if (!Validator.isEnoughPasswordLength(password)) return false
    return true
}

function onEditingFinishedPassword() {
    if (!$isValidPassowrd(passwordField.text)) {
        passwordField.borderColor = passwordField.warningColor
        passwordField.warning = "Некорректный пароль!"
    }
}

function onTextEditedPassword() {
    if ($isValidLogin(loginField.text)) {
        loginField.borderColor = loginField.defaultborderColor
        loginField.warning = ""
    }
}

// login proccess //
function login() {
    let fields = [loginField, passwordField]
    if (Validator.isAllValid(fields) && !Validator.isEmpty(fields)) {
        let answer = true
        if (loginField.text.indexOf('@') !== -1)
            answer = service.authentication(null, loginField.text, passwordField.text)
        else
            answer = service.authentication(loginField.text, null, passwordField.text)
        if (!answer) {
            $handleError()
        } else {
            windowManager.openMainWindow()
        }
    }
}

function $handleError() {
    if (service.isError()) {
        container.errorBarTextInfo = service.getServerMessage()
        container.errorBarVisible = true
    } else {
        let serverMessage = service.getServerMessage()
        loginField.warning = serverMessage
        loginField.borderColor = loginField.warningColor
        passwordField.borderColor = passwordField.warningColor
        container.errorBarVisible = false
    }
}