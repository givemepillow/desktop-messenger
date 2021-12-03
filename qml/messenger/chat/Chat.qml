import QtQuick 
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "../../templates"
import "../tools.js" as Tools

Rectangle {
    id: root 

    property bool anyChatIsOpen: false
    property string currentLogin: " "
    property string currentName: " "
    signal chatChanged()
    onChatChanged: messagesContainer.chatChanged()
    


    Image {
        id: backgroundImage
        source: "../../resources/images/background.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        visible: true
        antialiasing: true
    }

    ColorOverlay {
        anchors.fill: backgroundImage
        source: backgroundImage
        color: "#000000"
        antialiasing: true
        opacity: anyChatIsOpen ? 0.45 : 0.59
    }


    MessagesContainer {
        id: messagesContainer
        visible: anyChatIsOpen
    }
    

    InputContainer {
        id: inputContainer
        visible: anyChatIsOpen
    }

    Text {
        font.pointSize: 20
        color: "whitesmoke"
        visible: !anyChatIsOpen
        text: "Чтобы перейти к переписке -\nвыберите чат или найдите пользователя."
        anchors.centerIn: parent
        style: Text.Raised; styleColor: "gray"
        horizontalAlignment: Text.AlignHCenter
    }
    
}