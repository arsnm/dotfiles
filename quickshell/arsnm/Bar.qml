import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Pipewire

PanelWindow {
    id: barWindow
    anchors {
        bottom: true
        left: true
        right: true
    }

    // Bind PipeWire objects so QS actively tracks their state changes.
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    PowerMenu {
        id: powerMenu
        anchor.window: barWindow
        anchor.rect.x: 0
        anchor.rect.y: -6
    }

    implicitHeight: 30
    margins {
        bottom: 2
        top: 4
        left: 2
        right: 2
    }
    color: "transparent"

    // Helper component for the module containers (left, center, right)
    component ModuleGroup : Rectangle {
        color: Theme.bg
        border.color: Theme.fg
        border.width: 1
        radius: 2
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        implicitWidth: children[0].implicitWidth + 16
    }

    // ── Modules Left ─────────────────────────────────────────────────────
    ModuleGroup {
        anchors.left: parent.left

        RowLayout {
            anchors.centerIn: parent
            spacing: 8

            // Clock Module
            ModuleButton {
                id: clockBtn
                defaultColor: inactiveColor
                font.family: "Iosevka Nerd Font"
                font.weight: Font.Light

                property bool showDate: false
                property var currentTime: new Date()

                function updateDisplay() {
                    text = showDate
                        ? Qt.formatDateTime(currentTime, "[󰃭  ddd yyyy-MM-dd]")
                        : Qt.formatDateTime(currentTime, "[  hh:mm:ss ap]")
                }

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    triggeredOnStart: true
                    onTriggered: {
                        clockBtn.currentTime = new Date();
                        clockBtn.updateDisplay();
                    }
                }

                onClicked: {
                    showDate = !showDate;
                    updateDisplay();
                }
            }

            // Power Module
            ModuleButton {
                text: "[󰤆]"
                onClicked: powerMenu.visible = !powerMenu.visible
            }

            // Network Module
            NetworkModule {}

            // Bluetooth Module
            BluetoothModule {}

            // Microphone Module (Pipewire)
            ModuleButton {
                id: micBtn
                readonly property PwNode source: Pipewire.defaultAudioSource
                readonly property bool muted: source?.audio ? source.audio.muted : true

                text: muted ? "[󰍭]" : "[󰍬]"
                defaultColor: muted ? Theme.danger : Theme.micActive
                onClicked: {
                    if (source?.audio) source.audio.muted = !source.audio.muted
                }
            }
        }
    }

    // ── Modules Center ───────────────────────────────────────────────────
    ModuleGroup {
        anchors.horizontalCenter: parent.horizontalCenter

        RowLayout {
            anchors.centerIn: parent

            // Hyprland Workspaces.
            Repeater {
                model: Hyprland.workspaces
                ModuleButton {
                    required property HyprlandWorkspace modelData
                    property var icons: {
                        "1": "α",
                        "2": "β",
                        "3": "γ",
                        "4": "δ",
                        "5": "ε",
                        "6": "ζ",
                        "7": "η",
                        "8": "θ",
                    }
                    text: "[" + (icons[modelData.id.toString()] || modelData.id) + "]"
                    defaultColor: modelData.active ? Theme.danger : Theme.fg
                    onClicked: modelData.activate()
                    onScrolledUp: Hyprland.dispatch("hl.dsp.focus({ workspace = 'e+1' })")
                    onScrolledDown: Hyprland.dispatch("hl.dsp.focus({ workspace = 'e-1' })")
                }
            }
        }
    }


    // ── Modules Right ──────────────────────────────────────────────
    ModuleGroup {
        anchors.right: parent.right

        RowLayout {
            anchors.centerIn: parent
            spacing: 8

            // Keyboard Module.
            ModuleButton {
                id: kbdBtn
                property string currentSubmap: ""
                property bool isIntl: false

                readonly property var submapIcons: ({
                    "screen_mode": "",
                    "window_mode": "",
                })

                visible: currentSubmap !== "" || isIntl

                defaultColor: currentSubmap !== "" ? Theme.danger : Theme.fg

                text: {
                    let parts = []
                    if (currentSubmap !== "") {
                        let icon = submapIcons[currentSubmap] || "󰘳"
                        parts.push(`${icon}`)
                    }
                    if (isIntl) {
                        parts.push("I")
                    }
                    return parts.length > 0 ? "[" + parts.join(" ") + "]" : ""
                }

                Process {
                    id: initLayoutQuery
                    running: true
                    command: ["hyprctl", "-j", "devices"]
                    stdout: StdioCollector {
                        onStreamFinished: {
                            try {
                                let data = JSON.parse(this.text)
                                let kbd = data.keyboards.find(k => k.main) || data.keyboards[0]
                                if (kbd && kbd.active_key) {
                                    kbdBtn.isIntl = kbd.active_keymap.toLowerCase().includes("intl")
                                }
                            } catch (e) {
                                console.log("Failed to parse hyprctl devices:", e)
                            }
                        }
                    }
                }

                Connections {
                    target: Hyprland
                    function onRawEvent(event) {
                        if (event.name === "activelayout") {
                            let data = event.data || ""
                            let keymap = data.includes(",") ? data.split(",").slice(1).join(",") : data
                            kbdBtn.isIntl = keymap.toLowerCase().includes("intl")
                        } else if (event.name === "submap") {
                            let name = (event.data || "").trim()
                            kbdBtn.currentSubmap = (name === "reset") ? "" : name
                        }
                    }
                }

                onClicked: {
                    if (currentSubmap !== "") {
                        Hyprland.dispatch("hl.dsp.submap('reset')")
                    }
                }
            }

            // Volume Module.
            ModuleButton {
                id: volBtn

                readonly property PwNode sink: Pipewire.defaultAudioSink
                readonly property bool muted: sink?.audio ? sink.audio.muted : false
                readonly property int vol: sink?.audio ? Math.round(sink.audio.volume * 100) : 0

                defaultColor: {
                    muted || vol == 0 ? Theme.volMuted :
                            (vol < 33 ? Theme.volLow :
                            (vol < 66 ? Theme.volMid :
                            (vol < 100 ? Theme.volHigh : Theme.volVeryHigh)))
                }

                text: {
                    let displayVol = muted ? 0 : vol
                    let icon = muted ? "" :
                        (vol == 0 ? "" :
                            (vol < 33 ? "" :
                            (vol < 66 ? "" :
                            (vol < 100 ? "" : ""))))
                    let filled = Math.min(10, Math.max(0, Math.floor(displayVol / 10)))
                    let empty = 10 - filled
                    let bar = "[" + "".repeat(filled) + "".repeat(empty) + "]"
                    return `${icon} ${bar} ${displayVol}%`
                }

                onClicked: {
                    if (sink?.audio) sink.audio.muted = !sink.audio.muted
                }
                onScrolledUp: {
                    if (sink?.audio) sink.audio.volume = Math.min(1.5, sink.audio.volume + 0.05)
                }
                onScrolledDown: {
                    if (sink?.audio) sink.audio.volume = Math.max(0.0, sink.audio.volume - 0.05)
                }
            }
        }
    }
}
