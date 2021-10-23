import QtQuick
import "windowManager.js" as WindowManager

QtObject {
    id: windowManager

    function exit() {
        Qt.quit()
    }

    function openLoginWindow() {
        WindowManager.createWindow("windows/login/login.qml")
    }

    function openRegistrationWindow() {
        WindowManager.createWindow("windows/registration/registration.qml")
    }

    function openMainWindow() {
        WindowManager.createWindow("windows/main/main.qml")
    }

    Component.onCompleted: openLoginWindow()

}