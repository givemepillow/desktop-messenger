import "../templates"
import "../validator.js" as Validator

TemplateField {
    placeholderText: qsTr("Введите имя")
    readOnly: registrationBlock.isOff
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: 75
    }
    onEditingFinished: {
        if (!Validator.isValidName(text) && text !== "") {
            borderColor = warningColor
            warning = "Некорректное имя!"
        }
    }
}
