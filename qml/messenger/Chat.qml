import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../templates"

Rectangle {
    id: root
    width: parent.width * 0.7
    color: "transparent"
    anchors {
        right: parent.right
        top: parent.top
        bottom: parent.bottom
    }

    Image {
        id: backgroundImage
        source: "../resources/images/background.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        visible: true
        antialiasing: true
    }

    ColorOverlay {
        anchors.fill: backgroundImage
        source: backgroundImage
        color: "#000000"
        opacity: 0.4
        antialiasing: true
    }


    MessagesContainer {
        id: messagesContainer
    }
    

    InputContainer {
        id: inputContainer
    }
    
}