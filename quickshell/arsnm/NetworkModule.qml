/* import QtQuick */
/* import Quickshell */
/* import Quickshell.Io */
/* import Quickshell.Hyprland */

/* ModuleButton { */
/*     id: root */

/*     // "ethernet" | "wifi" | "disconnected". */
/*     property string activeType: "disconnected" */
/*     property string ethIface: "" */
/*     property int wifiQuality: 0 // 0 to 4. */

/*     text: switch(activeType) { */
/*             case "ethernet": return "[󰈁]" */
/*             case "wifi": { */
/*                 const icons = ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"] */
/*                 return `[${icons[wifiQuality]}]` */
/*             } */
/*             default: return "[󰪎]" */
/*     } */

/*     defaultColor: { */
/*         if (activeType === "ethernet" || activeType === "wifi") { */
/*             return Theme.fg */
/*         } else { */
/*             return Theme.danger */
/*         } */
/*     } */

/*     Process { */
/*         id: netMonitor */
/*         running: true */
/*         command: ["ip", "monitor", "link", "route"] */

/*         stdout: SplitParser { */
/*             splitMarker: "\n" */
/*             onRead: data => { */
/*                 netCheck.running = true */
/*             } */
/*         } */
/*     } */

/*     Process { */
/*         id: netCheck */
/*         running: true */
/*         command: ["ip", "-4", "-j", "route", "show", "default"] */

/*         stdout: StdioCollector { */
/*             onStreamFinished: { */
/*                 try { */
/*                     const routes = JSON.parse(this.text.trim()) */
/*                     if (!routes || routes.length === 0) { */
/*                         root.activeType = "disconnected" */
/*                         return */
/*                     } */

/*                     routes.sort((a, b) => (a.metric ?? 0) - (b.metric ?? 0)) */
/*                     const activeDev = routes[0].dev ?? "0" */

/*                     if (activeDev.startsWith("en") || activeDev.startsWith("eth")) { */
/*                         root.activeType = "ethernet" */
/*                         root.ethIface = activeDev */
/*                     } else if (activeDev.startsWith("wl")) { */
/*                         root.activeType = "wifi" */
/*                         root.ethIface = "" */
/*                         root.wifiQuality = root.readWifiTier(activeDev) */
/*                     } else { */
/*                         root.activeType = "disconnected" */
/*                     } */
/*                 } catch (_) { */
/*                     root.activeType = "disconnected" */
/*                 } */
/*             } */
/*         } */

/*         onExited: code => { */
/*             if (code !== 0) { */
/*                 root.activeType = "disconnected" */
/*             } */
/*         } */
/*     } */

/*     function readWifiTier(iface) { */
/*         const file = File.open("/proc/net/wireless", File.ReadOnly) */
/*         if (!file) return 0 */
/*         const content = file.ReadAll() */
/*         file.close() */

/*         const match = content.match(new RegExp(`${iface}:\\s*\\d+\\s+(\\d+)`)) */
/*         if (!match) return 0 */

/*         const quality = parseInt(match[1], 10) */
/*         // Scale is 0-70. */
/*         if (quality >= 56) return 4 */
/*         if (quality >= 42) return 3 */
/*         if (quality >= 28) return 2 */
/*         if (quality >= 14) return 1 */
/*         return 0 */
/*     } */

/*     Timer { */
/*         interval: 10000 */
/*         repeat: true */
/*         running: root.activeType === "wifi" */
/*         onTriggered: netCheck.running = true */
/*     } */

/*     Process { */
/*         id: ethToggle */
/*         command: [ */
/*             "sh", "-c", */
/*             "if [ -n '" + root.ethIface + "' ]; then " + */
/*             "  networkctl status " + root.ethIface + " | grep -q 'operational: routable' && " + */
/*             "  networkctl down " + root.ethIface + " || networkctl up " + root.ethIface + "; " + */
/*             "fi" */
/*         ] */
/*     } */

/*     onClicked: { */
/*         if (root.activeType === "ethernet") { */
/*             ethToggle.running = true */
/*         } else { */
/*             Hyprland.dispatch("hl.dsp.exec_raw('uwsm app -- kitty --class qs-float -e impala')") */
/*         } */
/*     } */
/* } */

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

ModuleButton {
    id: root

    // "ethernet" | "wifi" | "disconnected".
    property string activeType: "disconnected"
    property string ethIface: ""
    property int wifiQuality: 0 // 0 to 4.

    text: switch(activeType) {
            case "ethernet": return "[󰈁]"
            case "wifi": {
                const icons = ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"]
                return `[${icons[wifiQuality]}]`
            }
            default: return "[󰪎]"
    }

    defaultColor: {
        if (activeType === "ethernet" || activeType === "wifi") {
            return Theme.fg
        } else {
            return Theme.danger
        }
    }

    Process {
        id: netMonitor
        running: true
        command: ["ip", "monitor", "link", "route"]

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                netCheck.running = true
            }
        }
    }

    Process {
        id: netCheck
        running: true
        command: ["ip", "-4", "-j", "route", "show", "default"]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const routes = JSON.parse(this.text.trim())
                    if (!routes || routes.length === 0) {
                        root.activeType = "disconnected"
                        return
                    }

                    routes.sort((a, b) => (a.metric ?? 0) - (b.metric ?? 0))
                    const activeDev = routes[0].dev ?? "0"

                    if (activeDev.startsWith("en") || activeDev.startsWith("eth")) {
                        root.activeType = "ethernet"
                        root.ethIface = activeDev
                    } else if (activeDev.startsWith("wl")) {
                        root.activeType = "wifi"
                        root.ethIface = ""
                        root.wifiQuality = root.readWifiTier(activeDev)
                    } else {
                        root.activeType = "disconnected"
                    }
                } catch (_) {
                    root.activeType = "disconnected"
                }
            }
        }

        onExited: code => {
            if (code !== 0) {
                root.activeType = "disconnected"
            }
        }
    }

    function readWifiTier(iface) {
        const file = File.open("/proc/net/wireless", File.ReadOnly)
        if (!file) return 0
        const content = file.ReadAll()
        file.close()

        const match = content.match(new RegExp(`${iface}:\\s*\\d+\\s+(\\d+)`))
        if (!match) return 0

        const quality = parseInt(match[1], 10)
        // Scale is 0-70.
        if (quality >= 56) return 4
        if (quality >= 42) return 3
        if (quality >= 28) return 2
        if (quality >= 14) return 1
        return 0
    }

    Timer {
        interval: 10000
        repeat: true
        running: root.activeType === "wifi"
        onTriggered: netCheck.running = true
    }

    Process {
        id: ethToggle
        command: [
            "sh", "-c",
            "if [ -n '" + root.ethIface + "' ]; then " +
            "  networkctl status " + root.ethIface + " | grep -q 'operational: routable' && " +
            "  networkctl down " + root.ethIface + " || networkctl up " + root.ethIface + "; " +
            "fi"
        ]
    }

    onClicked: {
        if (root.activeType === "ethernet") {
            ethToggle.running = true
        } else {
            Hyprland.dispatch("hl.dsp.exec_raw('uwsm app -- kitty --class qs-float -e impala')")
        }
    }
}
