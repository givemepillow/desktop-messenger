function validateEmail(email) {
    const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}

function validateLogin(login) {
    const re = /^[0-9a-zA-Z\_]+$/;
    return re.test(String(login).toLowerCase());
}

function validateName(name) {
    const re1 = /^[а-яА-Я\-]+$/;
    const re2 = /^[a-zA-Z\-]+$/;
    return re1.test(String(name).toLowerCase()) || re2.test(String(name).toLowerCase());
}

function validatePassword(password) {
    const re = /^[a-zA-Z0-9\#\!\_\&\?\*\@\%\-\)\(\^\$]+$/;
    return re.test(String(password))
}

function isHardPassword(password) {
    if (password.match(/[0-9]/g) && password.match(/[a-zA-Z]/g) && password.match(/[#|!|_|&|?|)|(|@|*|-|%|^|$]/g)) {
        return true
    } else {
        return false
    }
}

function lengthPassword(login) {
    return String(login).length > 7 ? true : false
}

function equalPasswords(p1, p2) {
    return p1 === p2 ? true : false
}

function lengthLogin(login) {
    return String(login).length > 2 ? true : false
}

function isEmpty(args) {
    let isEmpty = false
    for (var i = 0; i < args.length; i++) {
        if (args[i].text == "") {
            args[i].warning = "Пустое поле!"
            args[i].borderColor = args[i].warningColor
            isEmpty = true
        }   
    }
    return isEmpty
}

function isAllValid(args) {
    let isAllValid = true
    for (var i = 0; i < args.length; i++) {
        if (args[i].warning !== "") {
            isAllValid = false
        }
    }
    return isAllValid
}