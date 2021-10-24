import "../templates"

TemplateField {
    placeholderText: qsTr("Введите email")
    readOnly: registrationBlock.isOff
    maximumLength: 50
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: loginField.bottom
        topMargin: 25
    }
}