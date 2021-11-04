import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
import "loginTools.js" as Tools
import "../templates"
import "../components"

TemplateWindow {
    id: window
    windowHeigth: 500
    windowWidht: 400

    TitleBar {
        id: titleBar
        title: "Desktop messenger. Login."
        minimizable: false
        maximizable: false
    }

    Container {
        id: container

        Label {
            id: header
            text: qsTr("Вход")
            font.pointSize: 36
            color: "white"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 40
            }
        }

        FieldLabel {
            id: loginFieldLabel
            field: loginField
            font.pointSize: 11
            anchors.leftMargin: (field.width - width) / 2
        }

        TemplateField {
            id: loginField
            placeholderText: qsTr("Введите ваш логин или email")
            maximumLength: 25 * 2
            focus: true
            anchors {
                top: parent.top
                topMargin: 150
                horizontalCenter: parent.horizontalCenter
            }
            onEditingFinished: Tools.onEditingFinishedEmailOrLogin()
            onAccepted: Tools.login()
            onFocusChanged: Tools.onFocusChanged()
        }
        
        FieldLabel {
            id: passwordFieldLabel
            field: passwordField
            font.pointSize: 11
            anchors.leftMargin: (field.width - width) / 2
        }

        PasswordField {
            id: passwordField
            placeholderText: qsTr("Введите пароль")
            anchors {
                top: loginField.bottom
                topMargin: 25
                horizontalCenter: parent.horizontalCenter
            }
            onEditingFinished: Tools.onEditingFinishedPassword()
            onAccepted: Tools.login()
            onFocusChanged: Tools.onFocusChanged()
        }

        TemplateButton {
            id: recoveryBtn1
            buttonText: "Забыли пароль?"
            width: 95
            height: 30
            enabled: false
            fontSize: 10
            colorTextDefault: "#a4a9b0"
            colorTextMouseOver: colorTextDefault
            colorTextClicked: colorTextDefault
            anchors {
                top: passwordField.bottom
                topMargin: -3
                right: recoveryBtn2.left
                rightMargin: 5
            }
        }
        TemplateButton {
            id: recoveryBtn2
            buttonText: "Восстановление пароля."
            width: 150
            height: 30
            fontSize: 10
            colorTextDefault: "#a4a9b0"
            colorTextMouseOver: "#e3bf30"
            colorTextClicked: "#e37e30"
            onClicked: windowManager.openRecoveryWindow()
            anchors {
                top: passwordField.bottom
                topMargin: -3
                right: passwordField.right
                rightMargin: 7
            }
        }

        ClassicButton {
            id: registrationProcessButton
            buttonText: "Войти"
            height: 40
            width: 200
            anchors {
                top: passwordField.bottom
                topMargin: 40
                horizontalCenter: parent.horizontalCenter
            }
            onClicked: Tools.login()
        }


        TemplateButton {
            id: regBtn1
            buttonText: "Ещё не зарегестрированы?"
            width: 200
            height: 30
            enabled: false
            fontSize: 11
            anchors {
                bottom: parent.bottom
                bottomMargin: 20
                left: parent.left
                leftMargin: (parent.width - (regBtn2.width + regBtn2.width)) / 4
            }
        }
        TemplateButton {
            id: regBtn2
            buttonText: "Регистрация"
            width: 100
            height: 30
            fontSize: 11
            colorTextMouseOver: "#e3bf30"
            colorTextClicked: "#e37e30"
            onClicked: windowManager.openRegistrationWindow()
            anchors {
                bottom: parent.bottom
                bottomMargin: 20
                left: regBtn1.right
            }
        }
    }
}