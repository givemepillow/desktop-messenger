import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "../../templates"

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

        Rectangle {
            id: registartionBlock

            width: 400
            color: "transparent"

            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }

            FirstNameField { id: firstNameField}
            SecondNameField { id: secondNameField}

            LoginField {id: loginField}
            EmailField {id: emailField}

            Password1Field {id: password1Field}
            Password2Field {id: password2Field}

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
                    onClicked: {
                        controller.registrationWindow()
                    }
                }
            }
        }       

    }
}