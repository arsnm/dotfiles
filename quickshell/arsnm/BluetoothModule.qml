import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

ModuleButton {
    id: root

    property bool isPowered: false
    property bool isConnected: false

    text: isConnected
        ? "[󰂱]"
        : (isPowered ? "[󰂯]" : "[󰂲]")

    defaultColor: isConnected
        ? Theme.micActive
        : (isPowered ? Theme.fg : Theme.danger)

    Process {
        id: btMonitor
        running: true
        command: ["bluetoothctl"]

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                let line = data.trim()
                if (line.includes("Connected") || line.includes("Powered")) {
                    console.log("changes in bl: ", data)
                    btCheck.running = true
                }
            }
        }
    }

    Process {
        id: btCheck
        running: true
        command: [
            "sh", "-c",
            "if bluetoothctl show | grep -q 'Powered: yes'; then " +
            "  if [ -n \"$(bluetoothctl devices Connected)\" ]; then exit 0; else exit 1; fi; " +
            "else exit 2; fi"
        ]
        onExited: code => {
            root.isPowered = (code === 0 || code === 1)
            root.isConnected = (code === 0)
        }
    }

    onClicked: Hyprland.dispatch("hl.dsp.exec_raw('uwsm app -- kitty --class qs-float -e bluetui')")
}
