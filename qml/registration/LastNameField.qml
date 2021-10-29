import "../templates"
import "../validator.js" as Validator

TemplateField {
    placeholderText: qsTr("Введите фамилию")
    readOnly: registrationBlock.isOff
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: firstNameField.bottom
        topMargin: 25
    }
    onEditingFinished: {
        if (!Validator.isValidName(text) && text !== "") {
            borderColor = warningColor
            warning = "Некорректное имя!"
        }
    }
}
