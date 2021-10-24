import "../templates"

TemplateField {
    placeholderText: qsTr("Введите фамилию")
    readOnly: registrationBlock.isOff
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: firstNameField.bottom
        topMargin: 25
    }
}
