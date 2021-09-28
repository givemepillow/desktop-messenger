import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "../../templates"

TemplateWindow {
    id: window
    windowHeigth: 500
    windowWidht: 400

    TitleBar {
        id: titleBar
        title: "Desktop messenger. Login."
        onMaximize: false
        onMinimize: false

    }
    Container {
        id: container
        color: "#3d3d3d"

        Column {
            id: inputBlock
            spacing: 15
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 100
            }

            LoginField {}
            PasswordField {}
            
        }

        TextButton {
            id: loginButton
            buttonText: qsTr("Войти")
            fontSize: 14
            width: 150
            colorMouseOver: "#38789d"
            colorDefault: "#e7276479"

            buttonRadius: 7


            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 100
            }

            onClicked: {
                    controller.mainWindow()
            }
        }

        Row {
            id: registrationBlock

            anchors {
                bottom: parent.bottom
                bottomMargin: 10
                horizontalCenter: parent.horizontalCenter
            }

            TextButton {
                id: registrationText
                buttonText: qsTr("Ещё не зарегистрированы?")
                width: 230
                colorClicked: "transparent"
                colorMouseOver: "transparent"
            }

            TextButton {
                id: registrationButton
                buttonText: qsTr("Регистрация.")
                width: 100
                colorTextClicked: "#1ccad9"
                colorClicked: "transparent"
                colorMouseOver: "transparent"
                colorTextMouseOver: "#88bfd2"
                onClicked: {
                    controller.registrationWindow()
                }
            }
        }
    }
}
