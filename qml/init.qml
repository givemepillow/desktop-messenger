import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15


Window {
    id: initWindow

    Component.onCompleted: {
        driver.load()
    }

    QtObject {
        id: driver
        function load() {
            let component = Qt.createComponent("welcome.qml")
            let win = component.createObject()
            win.show()
            visible = false
        }
    }
}






