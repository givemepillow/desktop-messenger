import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

AbstractButton {
    id: button

    property url iconSource: ""
    property string buttonText: ""
    property int buttonRadius: 0
    property int fontSize: 10
    property color colorDefault: "transparent"
    property color colorMouseOver: "transparent"
    property color colorClicked: "transparent"
    property color colorOverlayDefault: "whitesmoke"
    property color colorOverlayMouseOver: "whitesmoke"
    property color colorOverlayClicked: "whitesmoke"
    property color colorTextDefault: "whitesmoke"
    property color colorTextMouseOver: "whitesmoke"
    property color colorTextClicked: "whitesmoke"
    property bool fontUnderline: false

    property int iconHeight: 37
    property int iconWidth: 37


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
            font.underline: fontUnderline
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
            antialiasing: true
        }

        ColorOverlay {
            anchors.fill: iconButton
            source: iconButton
            color: internal.dynamicOverlayColor
            antialiasing: true
        }
    }
}