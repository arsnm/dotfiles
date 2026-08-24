import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io 

FloatingWindow { 
    id: root
    visible: false
    width: 200
    height: 175
    color: Theme.bg
    
    Process { id: sysAction }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

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
