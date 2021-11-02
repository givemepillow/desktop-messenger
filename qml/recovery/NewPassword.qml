import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
import "recoveryTools.js" as Tools
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
        text: "Придумайте новый пароль."
        font.pointSize: 13
        color: "whitesmoke"
        anchors {
            bottom: password1Field.top
            bottomMargin: 20
            horizontalCenter: password1Field.horizontalCenter
        }
    }

    FieldLabel { field: password1Field }
    Password1Field { 
        id: password1Field 
        focus: newPasswordBlock.visible
        onAccepted: Tools.setNewPassword()
    }

    FieldLabel { field: password2Field }
    Password2Field { 
        id: password2Field
        onAccepted: Tools.setNewPassword()
    }

    ClassicButton {
        id: loginOrEmailButton
        buttonText: "Сохнанить"
        width: 100
        anchors {
            top: password2Field.bottom
            topMargin: 30
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: Tools.setNewPassword()
    }

    SmokeButton {
        buttonText: qsTr("Отмена")
        onClicked: windowManager.openLoginWindow()
    }
}