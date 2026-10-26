import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Bluetooth
import Quickshell.Hyprland

ModuleButton {
    id: root

    readonly property var adapter: Bluetooth.defaultAdapter
    readonly property bool isPowered: Bluetooth.defaultAdapter?.state === BluetoothAdapterState.Enabled ?? false
    readonly property bool isConnected: {
        const devs = Bluetooth.devices?.values ?? null;

        if (!devs || devs.length == 0) return false;

        for (let i = 0; i < devs.length ; i++) {
            if (devs[i] && devs[i].connected) {
                return true
            }
        }

        return false
    }

    text: isConnected
        ? "[󰂱]"
        : (isPowered ? "[󰂯]" : "[󰂲]")

    defaultColor: isConnected
        ? Theme.micActive
        : (isPowered ? Theme.fg : Theme.danger)

    onClicked: Hyprland.dispatch("hl.dsp.exec_raw('uwsm app -- kitty --class qs-float -e bluetui')")
}
