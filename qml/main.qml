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

    function openMessengerWindow() {
        WindowManager.createWindow("messenger/main.qml")
    }

    function openRecoveryWindow() {
        WindowManager.createWindow("recovery/main.qml")
    }

    Component.onCompleted: {
        if (service.autoAuthentication()) {
            openMessengerWindow()
        } else {
            openLoginWindow()
        }
    }
}
