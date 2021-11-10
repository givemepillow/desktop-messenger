import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../templates"
import "tools.js" as Tools

Rectangle {
    id: root 

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