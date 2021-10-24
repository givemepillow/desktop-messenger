import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "functions"
import "../templates"

TemplateWindow {
    id: window
    windowHeigth: 720
    windowWidht: 980

    TitleBar {
        id: titleBar
        title: "Desktop messenger. Registration."
    }

    Container {
        id: container

        Rectangle {
            id: registrationBlock

            property bool isOff: false

            width: 400
            color: "transparent"

            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }

            Label {
                id: header
                text: qsTr("Регистрация")
                font.pointSize: 20
                color: "white"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: 15
                }
            }

            // First name field
            ErrorLabel {
                id: firstNameLabel
                field: firstNameField
            }
            FirstNameField {
                id: firstNameField;
            }
            // Last name field
            ErrorLabel {
                id: lastNameFieldLabel
                field: lastNameField
            }
            LastNameField {
                id: lastNameField;
            }
            // Login field
            ErrorLabel {
                id: loginFieldLabel
                field: loginField
            }
            LoginField {
                id: loginField;
            }
            // Email field
            ErrorLabel {
                id: emailFieldLabel
                field: emailField
            }
            EmailField {
                id: emailField;
            }
            // Password 1 field
            ErrorLabel {
                id: password1FieldLabel
                field: password1Field
            }
            Password1Field {
                id: password1Field;
            }
            // Password 2 field
            ErrorLabel {
                id: password2FieldLabel
                field: password2Field
            }
            Password2Field {
                id: password2Field
            }

            Label {
                text: qsTr("* Пароль должен содержать символы латинского\n   алфавита в верхем и нижнем регистре, цифры\n   и как миниум один из следующих символов:\n   ! № % @ _ ) ( ? $ ^ # * -")
                anchors {
                    left: password2Field.left
                    leftMargin: 5
                    top: password2Field.bottom
                    topMargin: 4
                }
                color: "whitesmoke"
            }

            Label {
                text: qsTr("* Вводите ваши настоящие данные")
                anchors {
                    left: lastNameField.left
                    leftMargin: 5
                    top: lastNameField.bottom
                    topMargin: 4
                }
                color: "whitesmoke"
            }

            Label {
                text: qsTr("* На него придёт письмо с кодом подтверждения")
                anchors {
                    left: emailField.left
                    leftMargin: 5
                    top: emailField.bottom
                    topMargin: 4
                }
                color: "whitesmoke"
            }
                
            TemplateButton {
                id: registrationProcessButton
                buttonText: "Зерегистрироваться"
                height: 45
                width: 230
                fontSize: 14
                buttonRadius: 7
                colorDefault: "#364d96"
                colorMouseOver: "#3e59b5"
                colorClicked: "#563eb5"
                anchors {
                    bottom: parent.bottom
                    bottomMargin: 60
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
                    emailValidation.visible = true
                    codeField.focus = true
                }
            }

            TemplateButton {
                id: loginBtn1
                buttonText: "Уже зарегестрированы?"
                width: 180
                height: 30
                enabled: false
                fontSize: 11
                anchors {
                    bottom: parent.bottom
                    bottomMargin: 20
                    left: parent.left
                    leftMargin: (parent.width - (loginBtn1.width + loginBtn2.width)) / 2
                }
            }
            TemplateButton {
                id: loginBtn2
                buttonText: "Вход"
                width: 50
                height: 30
                fontSize: 11
                colorTextMouseOver: "#e3bf30"
                colorTextClicked: "#e37e30"
                onClicked: windowManager.openLoginWindow()
                anchors {
                    bottom: parent.bottom
                    bottomMargin: 20
                    left: loginBtn1.right
                }
            }
        }


        Rectangle {
            id: emailValidation
            color: "#85000000"
            visible: false
            anchors {
                fill: parent
            }
            EmailCodeField {
                id: codeField
            }

            Label {
                property var field: null
                text: qsTr("Введите код, отправленный\nна указанный вами адрес электронной почты.")
                visible: true
                font.pointSize: 11
                color: "whitesmoke"
                horizontalAlignment: Text.AlignHCenter
                anchors {
                    bottom: codeField.top
                    bottomMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
            }
                
            TemplateButton {
                id: acceptButton
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: codeField.bottom
                    topMargin: 25
                }
                height: codeField.height - 15
                width: codeField.width - 30
                buttonText: qsTr("Подтвердить")
                fontSize: 13
                buttonRadius: 7
                colorDefault: "#364d96"
                colorMouseOver: "#3e59b5"
                colorClicked: "#563eb5"
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 2
                    verticalOffset: 2
                    color: "#50000000"
                }
                onClicked: {
                }
            }
            TemplateButton {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: acceptButton.bottom
                    topMargin: 10
                }
                width: 100
                height: 15
                fontSize: 10
                buttonText: qsTr("Отмена")
                colorDefault: "transparent"
                colorClicked: "transparent"
                colorMouseOver: "transparent"
                colorTextMouseOver: "#9e9e9e"
                colorTextClicked: "#ffffff"
                colorTextDefault: "#707070"
                onClicked: {
                    emailValidation.visible = false
                }
            }
            
        }

    }
}

