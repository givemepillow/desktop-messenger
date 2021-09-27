import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: button

    property url iconSource: ""
    property color colorDefault: "black"
    property color colorMouseOver: "blue"
    property color colorClicked: "red"

    property int iconHeight: 37
    property int iconWidth: 37

    QtObject {
        id: internal
        property var dynamicColor: button.down ? colorClicked : button.hovered ? colorMouseOver : colorDefault
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
            color: "white"
            antialiasing: false
        }
    }
}
