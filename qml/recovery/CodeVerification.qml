import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
import "recoveryTools.js" as Tools
import "../templates"
import "../components"

Rectangle {
    id: codeVerificationBlock
    height: 400
    width: height
    anchors.centerIn: parent
    color: "transparent"
    visible: false

    Label {
        id: codeVerificationLabel
        property TextField field: codeVerificationField
        text: field.warning == "" ? "Введите код" : field.warning
        visible: true
        font.pointSize: 18
        color: field.warning !== "" ? "#eb4034" : "whitesmoke"
        anchors {
            bottom: field.top
            bottomMargin: 10
            horizontalCenter: field.horizontalCenter
        }
    }

    TemplateField {
        id: codeVerificationField
        font.pixelSize: 20
        height: 40
        width: 180
        focus: codeVerificationBlock.visible
        maximumLength: 6
        inputMethodHints: Qt.ImhDigitsOnly
        horizontalAlignment: TextInput.AlignHCenter
        validator: IntValidator {bottom: 0; top: 999999}
        echoMode: TextInput.PasswordEchoOnEdit
        anchors {
            top: parent.top
            topMargin: 200
            horizontalCenter: parent.horizontalCenter
        }
        onAccepted: Tools.verifyCode()
    }


    ClassicButton {
        id: codeVerificationButton
        buttonText: "Подтвердить"
        height: 40
        width: 150
        fontSize: 12
        buttonRadius: 7
        anchors {
            top: codeVerificationField.bottom
            topMargin: 30
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: Tools.verifyCode()
    }

    SmokeButton {
        buttonText: qsTr("Назад")
        onClicked: {
            codeVerificationBlock.visible = false
            loginOrEmailBlock.visible = true
            codeVerificationField.text = ''
            codeVerificationField.warning = ''
        }
    }
}