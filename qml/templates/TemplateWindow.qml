import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {

    id: window

    flags: Qt.Window | Qt.FramelessWindowHint

    property int windowHeigth: 500
    property int windowWidht: 500
    property string windowTitle: "Window"

    width: windowWidht
    height: windowHeigth
    visible: true

    // TITLE BAR
    Rectangle {
        id: titleBar
        height: 30
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        color: "#3b3e42"
        // WINDOW BUTTONS
        Row {
            id: windowButtons
            width: 90
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
            Rectangle {width: parent.width / 3; height: parent.height; color: "green"}
            Rectangle {width: parent.width / 3; height: parent.height; color: "blue"}
            Rectangle {width: parent.width / 3; height: parent.height; color: "red"}
        }
        // WINDOW TITLE
        Rectangle {
            id: windowTitle
            color: "transparent"
            anchors {
                left: parent.left
                right: windowButtons.left
                top: parent.top
                bottom: parent.bottom
            }

            Label {
                color: "#cbdce2"
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 15
                }
                text: qsTr(window.windowTitle)
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Medium
                font.pointSize: 10
                font.family: "Arial"
                styleColor: "#e3f0f2"

            }

            DragHandler { onActiveChanged: if (active) window.startSystemMove() }
        }
    }

    // CONTAINER
    Rectangle {
        id: container
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: titleBar.bottom
        }
        color: "lightgreen"
    }

}
