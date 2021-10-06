import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

TextField {
    property color bgColor: "#37000000"
    property string warning: ""
    width: 300
    height: 40
    text: qsTr("")
    color: "white"
    selectByMouse: true
    font.pointSize: 10
    rightInset: 4
    verticalAlignment: Text.AlignVCenter
    background: Rectangle {
        anchors.fill: parent
        color: bgColor
        radius: 6
    }
    onPressed: {
        bgColor = "#37000000"
    }
    onTextEdited: warning = ""
}
    
    
