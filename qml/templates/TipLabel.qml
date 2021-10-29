import QtQuick
import QtQuick.Window
import QtQuick.Controls

Label {
    property TextField field: null
    text: field.tip
    visible: true
    font.pointSize: 10
    color: "#6fd453"
    anchors {
        bottom: field.top
        bottomMargin: 2
        left: field.left
        leftMargin: 3
    }
}