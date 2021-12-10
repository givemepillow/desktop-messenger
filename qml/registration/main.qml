import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
import "registrationTools.js" as Tools
import "../components"
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
            id: logoBlock
            color: "transparent"
            anchors {
                left: registrationBlock.right
                top: parent.top
                bottom: parent. bottom
                right: parent.right
            }
            Text {
                id: messengerLabel
                color: !registrationBlock.isOff ? "whitesmoke" : "#3d3d3d"
                text: "Desktop messenger"
                font.pointSize: 36
                anchors {
                    top: parent.top
                    topMargin: 275
                    left: parent.left
                    leftMargin: 20
                }
                
            }
             Text {
                color: !registrationBlock.isOff ? "whitesmoke" : "#3d3d3d"
                text: "by kirilllapushinskiy"
                font.pointSize: 26
                anchors {
                    top: messengerLabel.bottom
                    left: messengerLabel.left
                    leftMargin: 200
                }
                
            }
        }

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

            FirstNameField {
                id: firstNameField 
                onAccepted: Tools.registration()
            }
            FieldLabel { field: firstNameField }

            LastNameField {
                id: lastNameField
                onAccepted: Tools.registration()
            }
            FieldLabel { field: lastNameField }

            LoginField {
                id: loginField
                onAccepted: Tools.registration()
            }
            FieldLabel { field: loginField }
   
            EmailField {
                id: emailField
                onAccepted: Tools.registration()
            }
            FieldLabel { field: emailField }
            
            Password1Field {
                id: password1Field
                onAccepted: Tools.registration()
            }
            FieldLabel { field: password1Field }
            
            Password2Field {
                id: password2Field
                onAccepted: Tools.registration()
            }
            FieldLabel { field: password2Field }

            InfoLabel {
                text: qsTr("* Пароль должен содержать символы латинского\n   алфавита в верхем и нижнем регистре, цифры\n   и как миниум один из следующих символов:\n   ! @ _ ) + ( ? $ ^ # * -")
                anchors.left: password2Field.left
                anchors.top: password2Field.bottom
            }

            InfoLabel {
                text: qsTr("* Вводите ваши настоящие данные")
                anchors.left: lastNameField.left
                anchors.top: lastNameField.bottom
            }

            InfoLabel {
                text: qsTr("* На него придёт письмо с кодом подтверждения")
                anchors.left: emailField.left
                anchors.top: emailField.bottom
            }
                
            TemplateButton {
                id: registrationProcessButton
                buttonText: "Зерегистрироваться"
                enabled: !registrationBlock.isOff
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
                onClicked: Tools.registration()
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
                enabled: !registrationBlock.isOff
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
            id: emailValidationBlock
            color: "#85000000"
            visible: registrationBlock.isOff
            anchors {
                fill: parent
            }
            EmailCodeField {
                id: codeField
                focus: registrationBlock.isOff
                onTextEdited: {
                    codeLabel.text = codeLabel.defaultText
                    codeLabel.color = codeLabel.nonWarningColor
                    codeLabel.font.pointSize = 11
                }
                onAccepted: Tools.acceptCode()
            }

            Label {
                id: codeLabel
                property var field: null
                property string defaultText: qsTr("Введите код, отправленный\nна указанный вами адрес электронной почты.")
                text: defaultText
                visible: true
                font.pointSize: 15
                property color warningColor: "#d45353"
                property color nonWarningColor: "whitesmoke"
                color: nonWarningColor
                horizontalAlignment: Text.AlignHCenter
                anchors {
                    bottom: codeField.top
                    bottomMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
            }
                
            ClassicButton {
                id: acceptButton
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: codeField.bottom
                    topMargin: 25
                }
                height: codeField.height - 15
                width: codeField.width - 30
                buttonText: qsTr("Подтвердить")
                onClicked: Tools.acceptCode()
            }
            SmokeButton {
                anchors.bottomMargin: 30
                buttonText: qsTr("Отмена")
                onClicked: {
                    codeLabel.color = codeLabel.nonWarningColor
                    codeLabel.text = codeLabel.defaultText
                    codeField.text = ''
                    registrationBlock.isOff = false
                }
            }
        }

        Rectangle {
            id: registrationCompleteBlock
            anchors.fill: parent
            color: container.color
            visible: false

            Label {
                id: registrationCompleteLabel
                text: qsTr("Регистрация прошла успешно!")
                font.pointSize: 36
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: (parent.height - openLoginButton.height - height - 40) / 2
                }
                color: "whitesmoke"
            }

            ClassicButton {
                id: openLoginButton
                buttonText: "Авторизоваться"
                height: 45
                width: 230
                anchors {
                    top: registrationCompleteLabel.bottom
                    topMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                onClicked: windowManager.openLoginWindow()
            }
        }
    }
}
