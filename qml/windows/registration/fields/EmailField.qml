import "../../../templates"

TemplateField {
    placeholderText: qsTr("Введите email")
    maximumLength: 50
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: loginField.bottom
        topMargin: 25
    }
}