import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
import "recovery.js" as Recovery
import "../templates"
import "../components"


Rectangle {
    id: newPasswordBlock
    height: 400
    width: height
    anchors.centerIn: parent
    color: "transparent"
    visible: false

    Label {
        id: loginOrEmailErrorLabel
        text: "Придумайте новый пароль."
        visible: true
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 13
        color: "whitesmoke"
        width: parent.width
        height: contentHeight
        anchors {
            bottom: password1Field.top
            bottomMargin: 20
            horizontalCenter: field.horizontalCenter
        }
    }

    ErrorLabel {
        id: password1FieldLabel
        field: password1Field
    }
    TipLabel {
        id: password1FieldTipLabel
        field: password1Field
    }
    Password1Field {
        id: password1Field
    }

    ErrorLabel {
        id: password2FieldLabel
        field: password2Field
    }
    TipLabel {
        id: password2FieldTipLabel
        field: password2Field
    }
    Password2Field {
        id: password2Field
    }
    ClassicButton {
        id: loginOrEmailButton
        buttonText: "Сохнанить"
        height: 40
        width: 100
        fontSize: 12
        buttonRadius: 7
        anchors {
            top: password2Field.bottom
            topMargin: 30
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            let result = false
            let fileds = [password1Field, password2Field]
            if (Validator.isAllValid(fileds)) {
                if (Validator.isValidEmail(loginOrEmailBlock.loginOrEmail))
                    result = service.newPassword(loginOrEmailBlock.loginOrEmail, null, password1Field.text)
                else
                    result = service.newPassword(null, loginOrEmailBlock.loginOrEmail, password1Field.text)
                if (result) {
                    newPasswordBlock.visible= false
                    completeBlock.visible = true
                }
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