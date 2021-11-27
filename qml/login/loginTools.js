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

function onFocusChanged() {
    if ($isValidPassowrd(passwordField.password)) {
        passwordField.borderColor = passwordField.defaultborderColor
        passwordField.warning = ''
    }
    if ($isValidLogin(loginField.text)) {
        loginField.borderColor = loginField.defaultborderColor
        loginField.warning = ""
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

// login proccess //
function login() {
    //windowManager.openMessengerWindow()
    let fields = [loginField, passwordField]
    if (Validator.isAllValid(fields) && !Validator.isEmpty(fields)) {
        let answer = true
        if (loginField.text.indexOf('@') !== -1)
            answer = service.authentication(null, loginField.text, passwordField.text, checkBox.checkState == Qt.Checked)
        else
            answer = service.authentication(loginField.text, null, passwordField.text, checkBox.checkState == Qt.Checked)
        if (!answer) {
            $handleError()
        } else {
            windowManager.openMessengerWindow()
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