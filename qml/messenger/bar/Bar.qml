import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../../templates"

Rectangle {
    color: "#292929"
    height: 45
    Rectangle {
        color: "#3d3d3d"
        height: 1
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
    }
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: 2
        verticalOffset: 3
        color: "#30000000"
    }
}