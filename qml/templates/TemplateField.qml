import QtQuick
import QtQuick.Window
import QtQuick.Controls

TextField {
    property color defaultBgColor: "#37000000"
    property color defaultborderColor: "#262626"
    property color bgColor: defaultBgColor
    property color borderColor: defaultborderColor
    echoMode: TextInput.Normal
    maximumLength: 25
    width: 300
    height: 40
    color: "white"
    selectByMouse: true
    //font.pointSize: 11
    font.pixelSize: 16
    rightInset: 4
    verticalAlignment: Text.AlignVCenter
    background: Rectangle {
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
    
    
