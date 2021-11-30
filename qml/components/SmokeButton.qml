import "../templates"

TemplateButton {
    anchors {
        horizontalCenter: parent.horizontalCenter
        bottom: parent.bottom
        bottomMargin: 0
    }
    width: 100
    height: 15
    fontSize: 13
    buttonText: qsTr("Отмена")
    colorDefault: "transparent"
    colorClicked: "transparent"
    colorMouseOver: "transparent"
    colorTextMouseOver: "#9e9e9e"
    colorTextClicked: "#ffffff"
    colorTextDefault: "#707070"
}