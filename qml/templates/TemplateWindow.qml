import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: window

    flags: Qt.Window | Qt.FramelessWindowHint

    property int windowHeigth: 500
    property int windowWidht: 500

    minimumWidth: 300
    minimumHeight: 300

    width: windowWidht > minimumWidth ? windowWidht : minimumWidth
    height: windowHeigth > minimumHeight ? windowHeigth : minimumHeight
    visible: true
}
