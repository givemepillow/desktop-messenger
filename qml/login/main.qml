import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
import "../templates"

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

        Label {
            id: loginFieldLabel
            property TextField field: loginField
            text: field.warning
            visible: true
            font.pointSize: 11
            color: "#eb4034"
            anchors {
                bottom: field.top
                bottomMargin: 2
                horizontalCenter: field.horizontalCenter
            }
        }

        TemplateField {
            id: loginField
            placeholderText: qsTr("Введите ваш логин или email")
            maximumLength: 25 * 2
            anchors {
                top: parent.top
                topMargin: 150
                horizontalCenter: parent.horizontalCenter
            }

            function isValid() {
                let length = Validator.isEnoughLoginLength(text)
                let validEmail = Validator.isValidEmail(text)
                let validLogin = Validator.isValidLogin(text)

                if ((!length || (!validEmail && !validLogin)) && text !== "") {
                    return false
                }
                return true
            }

            onEditingFinished: {
                if (!isValid()) {
                    borderColor = warningColor
                    warning = "Некорректный логин или email!"
                }
            }

            onTextEdited: {
                if (passwordField.isValid()) {
                    passwordField.borderColor = passwordField.defaultborderColor
                }
            }
        }
        
        Label {
            id: passwordFieldLabel
            property TextField field: passwordField
            text: field.warning
            visible: true
            font.pointSize: 11
            color: "#eb4034"
            anchors {
                bottom: field.top
                bottomMargin: 2
                horizontalCenter: field.horizontalCenter
            }
        }

        PasswordField {
            id: passwordField
            placeholderText: qsTr("Введите пароль")
            anchors {
                top: loginField.bottom
                topMargin: 25
                horizontalCenter: parent.horizontalCenter
            }

            function isValid() {
                if ((!Validator.isValidPassword(text) || !Validator.isEnoughPasswordLength(text)) && text !== "") {
                    return false
                }
                return true
            }

            onEditingFinished: {
                if (!isValid()) {
                    borderColor = warningColor
                    warning = "Некорректный пароль!"
                }
            }

            onTextEdited: {
                if (loginField.isValid()) {
                    loginField.borderColor = loginField.defaultborderColor
                    loginField.warning = ""
                }
            }
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
                topMargin: -2
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
            colorOverlayClicked: "transparent"
            onClicked: windowManager.openRecoveryWindow()
            anchors {
                top: passwordField.bottom
                topMargin: -3
                right: passwordField.right
                rightMargin: 7
            }
        }

        TemplateButton {
            id: registrationProcessButton
            buttonText: "Войти"
            height: 40
            width: 200
            fontSize: 14
            buttonRadius: 7
            colorDefault: "#364d96"
            colorMouseOver: "#3e59b5"
            colorClicked: "#563eb5"
            anchors {
                top: passwordField.bottom
                topMargin: 40
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
                let fields = [loginField, passwordField]
                if (Validator.isAllValid(fields) && !Validator.isEmpty(fields)) {
                    let answer = true
                    if (loginField.text.indexOf('@') !== -1)
                        answer = service.authentication(null, loginField.text, passwordField.text)
                    else
                        answer = service.authentication(loginField.text, null, passwordField.text)
                    if (answer == false) {
                        if (service.isError()) {
                            container.errorBarTextInfo = service.getServerMessage()
                            container.errorBarVisible = true
                        } else {
                            let serverMessage = service.getServerMessage()
                            loginField.warning = serverMessage
                            loginField.borderColor = loginField.warningColor
                            passwordField.borderColor = passwordField.warningColor
                        }
                    } else {
                        windowManager.openMainWindow()
                    }
                }
            }
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