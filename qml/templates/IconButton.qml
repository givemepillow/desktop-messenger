import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: button

    property url iconSource: ""
    property color colorDefault: "transparent"
    property color colorMouseOver: "transparent"
    property color colorClicked: "red"
    property color colorOverlayDefault: "white"
    property color colorOverlayMouseOver: "white"
    property color colorOverlayClicked: "white"

    property int iconHeight: 37
    property int iconWidth: 37

    QtObject {
        id: internal
        property var dynamicColor: button.down ? colorClicked : button.hovered ? colorMouseOver : colorDefault
        property var dynamicOverlayColor: button.down ? colorOverlayClicked : button.hovered ? colorOverlayMouseOver : colorOverlayDefault
    }

    background: Rectangle {
        id: bgButton
        color: internal.dynamicColor

        anchors.fill: parent
        anchors.centerIn: parent

        Image {
            id: iconButton
            source: iconSource
            anchors.centerIn: parent
            height: button.iconHeight
            width: button.iconWidth
            fillMode: Image.PreserveAspectFit
            visible: false
            antialiasing: false
        }

        ColorOverlay {
            anchors.fill: iconButton
            source: iconButton
            color: internal.dynamicOverlayColor
            antialiasing: false
        }
    }
}
