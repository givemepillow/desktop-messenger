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
                field.warning = "Данный логин не зарегестрирован."
            } else {
                valid = true
            }
        } else {
            // For email.
            if (service.availableEmail(field.text)) {
                field.warning = "Данный email не зарегестрирован."
            } else {
                valid = true
            }
        }
    }
    return valid
}