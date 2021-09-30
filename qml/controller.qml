import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Item {
    id: controller
    visible: false

    signal loginWindow()
    onLoginWindow: {
        closeCurrentWindow()
        loadLogin()
    }
    signal mainWindow()
    onMainWindow: {
        closeCurrentWindow()
        loadMain()
    }
    signal registrationWindow()
    onRegistrationWindow: {
        closeCurrentWindow()
        loadRegistration()
    }

    property var currentWindow: null

    function closeCurrentWindow() { if (currentWindow != null) currentWindow.close() }

    function loadLogin() { 
        let component = Qt.createComponent("windows/login/login.qml")
        let win = component.createObject()
        win.show()
        currentWindow = win
    }

    function loadRegistration() {
        let component = Qt.createComponent("windows/registration/registration.qml")
        let win = component.createObject()
        win.show()
        currentWindow = win
    }

    function loadMain() {
        let component = Qt.createComponent("windows/main/main.qml")
        let win = component.createObject()
        win.show()
        currentWindow = win
    }

    Component.onCompleted: {
       controller.loginWindow()
       //controller.loadRegistration()
    }

}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
