import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../validator.js" as Validator
import "../templates"


Rectangle {
    
    EmailCodeField {
        id: codeField
        focus: registrationBlock.isOff
        onTextEdited: {
            codeLabel.text = codeLabel.defaultText
            codeLabel.color = codeLabel.nonWarningColor
            codeLabel.font.pointSize = 11
        }
    }

    Label {
        id: codeLabel
        property var field: null
        property string defaultText: qsTr("Введите код, отправленный\nна указанный вами адрес электронной почты.")
        text: defaultText
        visible: true
        font.pointSize: 11
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
        colorMouseOver: "#364d96"
        colorClicked: "#364d96"
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 2
            verticalOffset: 2
            color: "#50000000"
        }
        onClicked: {
            if (service.codeVerification(emailField.text, codeField.text)) {
                if (service.registration(
                    loginField.text,
                    emailField.text,
                    password1Field.text,
                    firstNameField.text,
                    lastNameField.text
                )) windowManager.openLoginWindow()
            } else {
                if (service.isError()) {
                    container.errorBarTextInfo = service.getServerMessage()
                    container.errorBarVisible = true
                    registrationBlock.isOff = false
                } else {
                    codeLabel.text = service.getServerMessage()
                    codeLabel.color = codeLabel.warningColor
                    codeLabel.font.pointSize = 16
                    codeField.focus = true
                    codeField.text = ""
                }
            }
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
            registrationBlock.isOff = false
        }
    }
    
}