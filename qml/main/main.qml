import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import "../templates"

TemplateWindow {
    id: window
    windowHeigth: 720
    windowWidht: 980

    TitleBar {
        id: titleBar
        title: "Desktop messenger."
    }
    Container {
        id: container
    }
}