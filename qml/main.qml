import QtQuick
import "windowManager.js" as WindowManager

QtObject {
    id: windowManager

    function exit() {
        Qt.quit()
    }

    function openLoginWindow() {
        WindowManager.createWindow("login/main.qml")
    }

    function openRegistrationWindow() {
        WindowManager.createWindow("registration/main.qml")
    }

    function openMainWindow() {
        WindowManager.createWindow("main/main.qml")
    }

    Component.onCompleted: openLoginWindow()
}
