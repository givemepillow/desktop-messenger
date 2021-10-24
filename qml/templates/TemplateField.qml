import QtQuick
import QtQuick.Window
import QtQuick.Controls

TextField {
    readonly property color defaultBgColor: "#37000000"
    readonly property color defaultborderColor: "#262626"
    property color bgColor: defaultBgColor
    property color borderColor: defaultborderColor
    echoMode: TextInput.Normal
    maximumLength: 25
    width: 300
    height: 40
    text: qsTr("")
    color: "white"
    selectByMouse: true
    font.pointSize: 11
    rightInset: 4
    verticalAlignment: Text.AlignVCenter
    background: Rectangle {
        anchors.fill: parent
        color: bgColor
        radius: 6
        border {
            width: 2
            color: borderColor
        }
    }
    onPressed: {
        bgColor = defaultBgColor
    }
    onTextEdited: {
        borderColor = defaultborderColor
    }
}
    
    
