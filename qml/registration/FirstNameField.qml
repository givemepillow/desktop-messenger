import "../templates"

TemplateField {
    placeholderText: qsTr("Введите имя")
    readOnly: registrationBlock.isOff
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: 75
    }
}
