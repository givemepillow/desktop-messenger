import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "../../templates"
import "functions"
import "fields"

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
        color: "#3d3d3d"

        ErrorBar {
            id: popup
            z: 10
        }

        Rectangle {
            id: registrationBlock

            property bool read: false

            width: 400
            color: "transparent"

            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }

            Registration {id: registration}

            ErrorLabel {field: firstNameField; id: firstNameLabel}
            FirstNameField {id: firstNameField; readOnly: registrationBlock.read}
            ErrorLabel {field: secondNameField; id: secondNameFieldLabel}
            SecondNameField { id: secondNameField; readOnly: registrationBlock.read}

            ErrorLabel {field: loginField; id: loginFieldLabel}
            LoginField {id: loginField; readOnly: registrationBlock.read}
            ErrorLabel {field: emailField; id: emailFieldLabel}
            EmailField {id: emailField; readOnly: registrationBlock.read}

            ErrorLabel {field: password1Field; id: password1FieldLabel}
            Password1Field {id: password1Field; readOnly: registrationBlock.read}
            ErrorLabel {field: password2Field; id: password2FieldLabel}
            Password2Field {id: password2Field; readOnly: registrationBlock.read}

            Rectangle {
                id: registrationProcessButton
                height: 50
                width: 250
                color: "transparent"
                anchors {
                    bottom: parent.bottom
                    bottomMargin: 50
                    horizontalCenter: parent.horizontalCenter
                }
                TextButton {
                    buttonText: qsTr("Регистрация.")
                    colorTextClicked: "#1ccad9"
                    colorDefault: "#2a4d73"
                    colorClicked: "#135fb0"
                    colorMouseOver: "deepskyblue"
                    colorTextMouseOver: "whitesmoke"
                    width: parent.width
                    buttonRadius: 7
                    enabled: true
                    onClicked: {
                        if(registration.validation()) {
                            if (account.email_and_login(emailField.text, loginField.text)) {
                                registrationBlock.read = true
                                enabled = false
                                popup.text_info = account.get_server_message()
                                emailValidation.visible = true
                            } else {
                                popup.text_info = account.get_server_message()
                                popup.visible = true
                            }
                        }
                    }
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
            EmailCodeField {id: codeField}

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
            Rectangle {
                id: acceptButton
                color: "transparent"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: codeField.bottom
                    topMargin: 25
                }
                height: codeField.height - 15
                width: codeField.width - 30
                TextButton {
                    buttonText: qsTr("Подтвердить")
                    colorTextClicked: "#1ccad9"
                    colorDefault: "#2a4d73"
                    colorClicked: "#135fb0"
                    colorMouseOver: "deepskyblue"
                    colorTextMouseOver: "whitesmoke"
                    width: parent.width
                    buttonRadius: 7
                    enabled: true
                    onClicked: {
                        if (account.verification(emailField.text, codeField.text)) {
                            if(registration.registration()){
                                controller.loginWindow()
                            } else {
                                popup.text_info = account.get_server_message()
                                popup.visible = true
                            }
                        } else {
                            popup.text_info = account.get_server_message()
                            popup.visible = true
                        }
                    }
                }
            }
            Rectangle {
                color: "transparent"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: acceptButton.bottom
                    topMargin: 10
                }
                width: 100
                height: 15
                TextButton {
                    fontSize: 10
                    buttonText: qsTr("Отмена")
                    colorDefault: "transparent"
                    colorClicked: "transparent"
                    colorMouseOver: "transparent"
                    colorTextMouseOver: "#9e9e9e"
                    colorTextClicked: "#ffffff"
                    colorTextDefault: "#707070"
                    width: parent.width
                    enabled: true
                    onClicked: {
                        emailValidation.visible = false
                    }
                }
            }
        }

    }
}

