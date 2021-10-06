import QtQuick 2.15

Item {

    Validate {id: vl}

    function start() {
        let valid = true

        if (! vl.longPassword(password1Field)) valid = false
        if (! vl.hardPassword(password1Field)) valid = false
        if (! vl.correctPassword(password1Field)) valid = false
        if (! vl.identicalPasswords(password1Field, password2Field)) valid = false

        if (vl.nullField(firstNameField)) valid = false
        if (vl.nullField(secondNameField)) valid = false
        if (vl.nullField(loginField)) valid = false
        if (vl.nullField(emailField)) valid = false
        if (vl.nullField(password1Field)) valid = false
        if (vl.nullField(password2Field)) valid = false
        
        
        if (valid) {
            let answer = account.registration(
                loginField.text,
                password1Field.text,
                firstNameField.text,
                secondNameField.text,
                emailField.text
            )
            if (answer) {
                controller.loginWindow()
            } else {
                popup.open()
            }
        }             
    }
}