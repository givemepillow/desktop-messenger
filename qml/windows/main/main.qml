import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "../../templates"

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
        color: "lightblue"
    }
}