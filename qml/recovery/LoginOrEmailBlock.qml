import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
import "recovery.js" as Recovery
import "../templates"

Rectangle {
    id: loginOrEmailBlock
    height: 400
    width: height
    anchors.centerIn: parent
    color: "transparent"

    property string loginOrEmail: ""

    Label {
        id: loginOrEmailErrorLabel
        property TextField field: loginOrEmailField
        text: field.warning == "" ? "Для восстановления пароля введите\nваш логин или адрес электронной почты,\nпривязанный к аккаунту." : field.warning
        visible: true
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 11
        color: field.warning !== "" ? "#eb4034" : "whitesmoke"
        width: parent.width
        height: contentHeight
        anchors {
            bottom: field.top
            bottomMargin: 10
            horizontalCenter: field.horizontalCenter
        }
    }

    LoginOrEmailField {
        id: loginOrEmailField
    }

    TemplateButton {
        id: loginOrEmailButton
        buttonText: "Отправить код подтверждения"
        height: 40
        width: 250
        fontSize: 12
        buttonRadius: 7
        colorDefault: "#364d96"
        colorMouseOver: "#3e59b5"
        colorClicked: "#563eb5"
        anchors {
            top: loginOrEmailField.bottom
            topMargin: 30
            horizontalCenter: parent.horizontalCenter
        }
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 2
            verticalOffset: 2
            color: "#50000000"
        }
        onClicked: {
            loginOrEmailField.nextStep()
        }           
    }

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
        onClicked: {
            windowManager.openLoginWindow()
        }
    }
}