import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

PopupWindow {
    id: root
    visible: false
    implicitWidth: 160
    implicitHeight: 185
    color: Theme.bg

    grabFocus: true

    anchor {
        edges: Edges.Top | Edges.Left
        gravity: Edges.Top | Edges.Right
        margins.bottom: 6
    }

    Process { id: sysAction }

    Rectangle {
        anchors.fill: parent;
        color: Theme.bg;
        border.color: Theme.fg;
        border.width: 1
        radius: 2

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 4

            component MenuBtn : Button {
                Layout.fillWidth: true
                background: Rectangle {
                    color: parent.hovered ? Theme.bgHover : "transparent"
                    radius: 2
                }
                contentItem: Text {
                    text: parent.text
                    color: Theme.fg
                    font.family: "JetBrainsMono Nerd Font Mono"
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            MenuBtn {
                text: "Lock"
                onClicked: { sysAction.command = ["hyprlock"]; sysAction.running = true; root.visible = false }
            }
            MenuBtn {
                text: "Suspend"
                onClicked: { sysAction.command = ["systemctl", "suspend"]; sysAction.running = true; root.visible = false }
            }
            MenuBtn {
                text: "Logout"
                onClicked: { sysAction.command = ["hyprctl", "dispatch", "exit"]; sysAction.running = true }
            }
            MenuBtn {
                text: "Reboot"
                onClicked: { sysAction.command = ["systemctl", "reboot"]; sysAction.running = true }
            }
            MenuBtn {
                text: "Shutdown"
                onClicked: { sysAction.command = ["systemctl", "poweroff"]; sysAction.running = true }
            }
        }
    }
}
