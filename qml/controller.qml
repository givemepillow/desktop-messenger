import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Item {
    id: controller
    visible: false

    signal loginWindow()
    onLoginWindow: loadWelcome()
    signal registrationWindow()
    onRegistrationWindow: loadWelcome()

    property var currentWindow: null

    function closeCurrentWindow() { if (currentWindow != null) currentWindow.close() }

    function loadLogin() {
        closeCurrentWindow()
        let component = Qt.createComponent("windows/login/main.qml")
        let win = component.createObject()
        win.show()
        currentWindow = win
    }

    function loadRegistration() {
        closeCurrentWindow()
        let component = Qt.createComponent("windows/registration/main.qml")
        let win = component.createObject()
        win.show()
        currentWindow = win
    }

    Component.onCompleted: {
       // controller.loadLogin()
       controller.loadRegistration()
    }
    
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
