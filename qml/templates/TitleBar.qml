import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: titleBar

    property string title: "Window"
    property bool onMinimize: true
    property bool onMaximize: true
    property bool onClose: true

    height: 30
    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
    }
    color: "#262626"
    // WINDOW BUTTONS
    Row {
        id: windowButtons
        width: 90
        layoutDirection: Qt.RightToLeft
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }

        IconButton {
            id: closeButton
            visible: onClose
            width: parent.width / 3; height: parent.height;
            colorMouseOver: "#616161"
            colorClicked: "#ba3b32"
            onClicked: controller.exit()
            iconSource: "../resources/icons/close.png"
        }

        IconButton {
            id: maximizeButton
            width: parent.width / 3; height: parent.height;
            visible: onMaximize
            colorMouseOver: "#616161"
            colorClicked: "#616161"
            onClicked: controller.closeCurrentWindow()
            iconSource: "../resources/icons/maximize.png"
        }
        IconButton {
            id: minimizeButton
            visible: onMinimize
            width: parent.width / 3; height: parent.height;
            colorMouseOver: "#616161"
            colorClicked: "#616161"
            onClicked: controller.closeCurrentWindow()
            iconSource: "../resources/icons/minimize.png"
        }


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
            text: qsTr(titleBar.title)
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
