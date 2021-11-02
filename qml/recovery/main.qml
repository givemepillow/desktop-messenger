import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../templates"

TemplateWindow {
    id: window
    windowHeigth: 500
    windowWidht: 400

    TitleBar {
        id: titleBar
        title: "Recovery."
    }
    Container {
        id: container

        Label {
            text: qsTr('Восстановление пароля')
            color: "whitesmoke"
            font.pointSize: 24 
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 50
            }
        }

        LoginOrEmail {id: loginOrEmailBlock }

        CodeVerification { id: codeVerificationBlock }

        NewPassword { id: newPasswordBlock }

        Complete { id: completeBlock }
    }
}