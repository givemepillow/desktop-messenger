import "../templates"

TemplateField {
    placeholderText: qsTr("Придумайте логин")
    readOnly: registrationBlock.isOff
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: lastNameField.bottom
        topMargin: 50
    }
}
