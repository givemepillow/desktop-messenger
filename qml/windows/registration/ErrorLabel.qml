import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Label {
    property var field: null
    text: field.warning
    visible: true
    font.pointSize: 9
    color: "#eb4034"
    anchors {
        bottom: field.top
        bottomMargin: 2
        left: field.left
        leftMargin: 3
    }
}