import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
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

    CodeVerificationField {
        id: codeVerificationField
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