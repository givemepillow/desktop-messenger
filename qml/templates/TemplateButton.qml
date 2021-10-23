import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Button {
    id: button

    property url iconSource: ""
    property string buttonText: ""
    property int buttonRadius: 0
    property int fontSize: 10
    property color colorDefault: "transparent"
    property color colorMouseOver: "transparent"
    property color colorClicked: "red"
    property color colorOverlayDefault: "white"
    property color colorOverlayMouseOver: "white"
    property color colorOverlayClicked: "white"
    property color colorTextDefault: "white"
    property color colorTextMouseOver: "white"
    property color colorTextClicked: "white"

    property int iconHeight: 37
    property int iconWidth: 37

    height: 50
    width: 50

    flat: true
    highlighted: false

    QtObject {
        id: internal
        property var dynamicColor: button.down ? colorClicked : button.hovered ? colorMouseOver : colorDefault
        property var dynamicOverlayColor: button.down ? colorOverlayClicked : button.hovered ? colorOverlayMouseOver : colorOverlayDefault
        property var dynamicTextColor: button.down ? colorTextClicked : button.hovered ? colorTextMouseOver : colorTextDefault
    }

    background: Rectangle {
        id: bgButton
        color: internal.dynamicColor

        anchors.fill: parent
        anchors.centerIn: parent

        radius: buttonRadius

        Text {
            id: buttonText
            anchors {
                fill: parent
                centerIn: parent
            }
            text: qsTr(button.buttonText)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: fontSize
            font.family: "Arial"
            color: internal.dynamicTextColor
        }

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