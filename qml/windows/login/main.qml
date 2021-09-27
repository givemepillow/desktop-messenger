import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "../../templates"

TemplateWindow {
    id: window
    windowHeigth: 500
    windowWidht: 400

    TitleBar {
        id: titleBar
        title: "Desktop messenger. Login."
        onMaximize: false
        onMinimize: false

    }
    Container {
        id: container
        color: "darkgrey"
    }
}
