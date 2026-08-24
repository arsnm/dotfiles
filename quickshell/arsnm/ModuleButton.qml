import QtQuick
import QtQuick.Controls

Rectangle {
    id: root

    // Properties to allow per-module customization.
    property alias text: label.text
    property alias textFormat: label.textFormat
    property alias font: label.font

    property string defaultColor: Theme.fg
    property string dangerColor: Theme.danger
    property string activeColor: Theme.active
    property string inactiveColor: Theme.inactive

    signal clicked()
    signal scrolledUp()
    signal scrolledDown()


    color: mouse.containsMouse ? Theme.bgHover : "transparent"
    border.color: mouse.containsMouse ? Theme.active : "transparent"
    border.width: mouse.containsMouse ? 1 : 0
    radius: 2

    // Padding: 1px 3px (x2).
    implicitWidth: label.implicitWidth + 6
    implicitHeight: label.implicitHeight + 6

    Text {
        id: label
        anchors.centerIn: parent
        color: mouse.containsMouse ? root.activeColor : root.defaultColor
        font.family: "Iosevka Nerd Font Mono"
        font.pixelSize: 14
        textFormat: Text.PlainText
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton

        onClicked: root.clicked()
        onWheel: {
            if (wheel.angleDelta.y > 0) root.scrolledUp()
            else root.scrolledDown()
        }
    }
}
