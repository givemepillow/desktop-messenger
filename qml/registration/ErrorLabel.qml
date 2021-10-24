import QtQuick
import QtQuick.Window
import QtQuick.Controls

Label {
    property TextField field: null
    text: field.warning
    visible: true
    font.pointSize: 10
    color: "#eb4034"
    anchors {
        bottom: field.top
        bottomMargin: 2
        left: field.left
        leftMargin: 3
    }
}