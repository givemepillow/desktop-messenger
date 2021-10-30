import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
import "../templates"

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

    CodeVerificationField {
        id: codeVerificationField
    }


    TemplateButton {
        id: codeVerificationButton
        buttonText: "Подтвердить"
        height: 40
        width: 150
        fontSize: 12
        buttonRadius: 7
        colorDefault: "#364d96"
        colorMouseOver: "#3e59b5"
        colorClicked: "#563eb5"
        anchors {
            top: codeVerificationField.bottom
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
            let valid = false
            if (Validator.isValidEmail(loginOrEmailBlock.loginOrEmail))
                valid = service.recoveryCodeVerification(loginOrEmailBlock.loginOrEmail, null, codeVerificationField.text)
            else
                valid = service.recoveryCodeVerification(null, loginOrEmailBlock.loginOrEmail, codeVerificationField.text)
            if (valid) {
                codeVerificationBlock.visible = false
                newPasswordBlock.visible = true
            } else {
                codeVerificationField.warning = service.getServerMessage()
            }
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
        buttonText: qsTr("Назад")
        colorDefault: "transparent"
        colorClicked: "transparent"
        colorMouseOver: "transparent"
        colorTextMouseOver: "#9e9e9e"
        colorTextClicked: "#ffffff"
        colorTextDefault: "#707070"
        onClicked: {
            codeVerificationBlock.visible = false
            loginOrEmailBlock.visible = true
            codeVerificationField.text = ''
            codeVerificationField.warning = ''
        }
    }
}