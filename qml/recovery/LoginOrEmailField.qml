import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
import "recovery.js" as Recovery
import "../templates"


TemplateField {
    id: loginOrEmailField
    placeholderText: qsTr("Введите ваш логин или email")
    maximumLength: 25 * 2
    focus: true
    anchors {
        top: parent.top
        topMargin: 200
        horizontalCenter: parent.horizontalCenter
    }
    onAccepted: nextStep()
    function nextStep() {
        if (Recovery.isValidLoginOrEmail(loginOrEmailField)) {
            loginOrEmail = loginOrEmailField.text
            if (Validator.isValidEmail(loginOrEmailField.text)) {
                if (service.recoveryEmailVerification(loginOrEmailField.text, null)) {
                    codeVerificationBlock.visible = true
                    loginOrEmailBlock.visible = false
                }
            } else {
                if (service.recoveryEmailVerification(null, loginOrEmailField.text, )) {
                    codeVerificationBlock.visible = true
                    loginOrEmailBlock.visible = false
                }
            }
            
        }
    }
}