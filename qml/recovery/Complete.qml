import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../templates"
import "../components"


Rectangle {
    id: completeBlock
    height: parent.height
    width: parent.width
    anchors.centerIn: parent
    color: parent.color
    visible: false
    focus: completeBlock.visible

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

    ClassicButton {
        id: openLoginButton
        buttonText: "Авторизоваться"
        width: 230
        anchors {
            top: completeLabel.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: windowManager.openLoginWindow()
    }
    Keys.onPressed: {
        windowManager.openLoginWindow()
    }
}