import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "../../templates"

TemplateField {
    id: usernameField
    placeholderText: qsTr("Введите ваш логин или email")
    anchors {
        horizontalCenter: parent.horizontalCenter
    }
}
