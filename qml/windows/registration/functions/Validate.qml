import QtQuick 2.15

QtObject {
    function nullField(field) {
    if (field.text === "") {
        field.bgColor = "#6dba3737"
        field.warning = "Обязательное поле!"
        return true
    } else {
        return false
    }
}
}