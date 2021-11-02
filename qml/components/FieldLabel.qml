import QtQuick
import QtQuick.Window
import QtQuick.Controls

Label {
    property TextField field: null
    text: field.warning != '' ? field.warning : field.tip
    visible: true
    font.pointSize: 10
    color: field.warning != '' ? "#eb4034" : "#6fd453" // red : green
    anchors {
        bottom: field.top
        bottomMargin: 2
        left: field.left
        leftMargin: 3
    }
}