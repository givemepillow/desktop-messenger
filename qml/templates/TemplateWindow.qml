import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

ApplicationWindow {

    id: window

    flags: Qt.Window | Qt.FramelessWindowHint

    property int windowHeigth: 500
    property int windowWidht: 500
    property string windowTitle: "Window"

    width: windowWidht
    height: windowHeigth
    visible: true
    title: qsTr(windowTitle)

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

}