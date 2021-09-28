import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: button

    property string buttonText: "btn"
    property int buttonRadius: 0
    property int fontSize: 10
    property color colorDefault: "transparent"
    property color colorMouseOver: "blue"
    property color colorClicked: "red"
    property color colorDefaultText: "white"
    property color colorTextMouseOver: "white"
    property color colorTextClicked: "white"


    height: 50
    width: 50

    QtObject {
        id: internal
        property var dynamicButtonColor: button.down ? colorClicked : button.hovered ? colorMouseOver : colorDefault
        property var dynamicTextColor: button.down ? colorTextClicked : button.hovered ? colorTextMouseOver : colorDefaultText
    }

    background: Rectangle {
        id: bgButton
        color: internal.dynamicButtonColor

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

    }
}
