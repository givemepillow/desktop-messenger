import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../templates"


Rectangle {
    id: newPasswordBlock
    height: parent.height
    width: parent.width
    anchors.centerIn: parent
    color: parent.color
    visible: false

    Label {
        id: completeLabel
        text: qsTr('Пароль успешно обновлён!')
        color: "whitesmoke"
        font.pointSize: 20
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 185
        }
    }

    TemplateButton {
        id: openLoginButton
        buttonText: "Авторизоваться"
        height: 45
        width: 230
        fontSize: 14
        buttonRadius: 7
        colorDefault: "#364d96"
        colorMouseOver: "#3e59b5"
        colorClicked: "#563eb5"
        anchors {
            top: completeLabel.bottom
            topMargin: 20
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
            windowManager.openLoginWindow()
        }
    }
}