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

        ErrorLabel {
            id: loginFieldLabel
            field: loginField
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
            onEditingFinished: {
                let length = Validator.lengthLogin(text)
                let validEmail = Validator.validateEmail(text)
                let validLogin = Validator.validateLogin(text)

                if ((!length || (!validEmail && !validLogin)) && text !== "") {
                    borderColor = warningColor
                    warning = "Некорректный логин или email!"
                }
            }
        }

        ErrorLabel {
            id: passwordFieldLabel
            field: passwordField
        }

        PasswordField {
            id: passwordField
            placeholderText: qsTr("Введите пароль")
            anchors {
                top: loginField.bottom
                topMargin: 25
                horizontalCenter: parent.horizontalCenter
            }
            onEditingFinished: {
                if ((!Validator.validatePassword(text) || !Validator.lengthPassword(text)) && text !== "") {
                    borderColor = warningColor
                    warning = "Некорректный пароль!"
                }
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