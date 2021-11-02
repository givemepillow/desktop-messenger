import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
import "recoveryTools.js" as Tools
import "../templates"
import "../components"

Rectangle {
    id: loginOrEmailBlock
    height: 400
    width: height
    anchors.centerIn: parent
    color: "transparent"

    property string loginOrEmail: ""

    Label {
        text: "Для восстановления пароля введите\nваш логин или адрес электронной почты,\nпривязанный к аккаунту."
        color: "whitesmoke"
        font.pointSize: 12
        height: contentHeight
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        anchors {
            top: parent.top
            topMargin: 100
            horizontalCenter: parent.horizontalCenter
        }
    }

    FieldLabel {
        id: loginOrEmailErrorLabel
        field: loginOrEmailField
        font.pointSize: 11
        anchors.leftMargin: (field.width - width) / 2
    }
    TemplateField {
        id: loginOrEmailField
        placeholderText: qsTr("Введите ваш логин или email")
        maximumLength: 25 * 2
        focus: loginOrEmailBlock.visible
        anchors {
            top: parent.top
            topMargin: 200
            horizontalCenter: parent.horizontalCenter
        }
        onAccepted: Tools.sendCode()
        
    }

    ClassicButton {
        id: loginOrEmailButton
        buttonText: "Отправить код подтверждения"
        height: 40
        width: 250
        fontSize: 12
        buttonRadius: 7
        anchors {
            top: loginOrEmailField.bottom
            topMargin: 30
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: Tools.sendCode()         
    }

    SmokeButton {
        buttonText: qsTr("Отмена")
        onClicked: windowManager.openLoginWindow()
    }
}