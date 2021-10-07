import "../../../templates"

TemplateField {
    placeholderText: qsTr("Введите фамилию")
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: firstNameField.bottom
        topMargin: 25
    }
}
