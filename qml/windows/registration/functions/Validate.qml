import QtQuick 2.15

QtObject {

    function warningColors(field) {
        field.bgColor = "#3d2727"
        field.borderColor = "#ad2424"
    }

    function nullField(field) {
        if (field.text === "") {
            warningColors(field)
            field.warning = "Обязательное поле!"
            return true
        } else {
            return false
        }
    }

    function longPassword(field) {
        if (field.text.length >= 8) {
            return true
        } else {
            warningColors(field)
            field.warning = "Пароль должен состоять минимум из 8 символов!"
            return false
        }
    }

    function correctPassword(field){
        if (! field.text.match(/[^a-zA-Z0-9#!_&?]/g)) {
            return true
        } else {
            warningColors(field)
            field.warning = "Допустимые символы: A-z 0-9 _ # ! $ ? &"
            return false
        }
    }

    function hardPassword(field) {
        if (field.text.match(/[0-9]/g) && field.text.match(/[a-zA-Z]/g) && field.text.match(/[#|!|_|&|?]/g)) {
            return true
        } else {
            warningColors(field)
            field.warning = "Слабый пароль, добавьте: A-z _ # ! $ ? &"
            return false
        }
    }

    function identicalPasswords(f1, f2) {
        if (f1.text !== f2.text) {
            warningColors(f2)
            f2.warning = "Пароли не совпадают!"
            return false
        } else {
            return true
        }
    }
}
