import "../templates"

TemplateField {
    placeholderText: qsTr("Придумайте логин")
    readOnly: registrationBlock.isOff
    maximumLength: 25
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: lastNameField.bottom
        topMargin: 50
    }
}
