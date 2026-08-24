import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io

PanelWindow {
    id: barWindow
    anchors {
        bottom: true
        left: true
        right: true
    }

    PowerMenu {
        id: powerMenu
    }

    height: 38
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
        Layout.fillHeight: true
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // ── Modules Left ─────────────────────────────────────────────────────
        ModuleGroup {
            RowLayout {
                anchors.centerIn: parent
                spacing: 8

                // Clock Module
                ModuleButton {
                    id: clockBtn
                    defaultColor: inactiveColor
                    font.pixelSize: 12
                    font.weight: Font.Bold

                    Timer {
                        interval: 1000; running: true; repeat: true
                        onTriggered: clockBtn.text = Qt.formatDateTime(
                            new Date(),
                            "[ hh:mm:ss ap]"
                        )
                    }
                }

                // Power Module
                ModuleButton {
                    text: "[󰤆]"
                    onClicked: powerMenu.visible = !powerMenu.visible
                }

                // Network Module (Native replacement for polling)
                ModuleButton {
                    text: "[󰤨]" // Placeholder, ideally bound to NetworkManager DBus in full setups
                }

                // Bluetooth Module
                ModuleButton {
                    text: "[]"
                    Process {
                        id: btToggle
                        command: [
                            "zsh",
                            "-c",
                            "rfkill list bluetooth | grep -q 'Soft blocked: yes' && rfkill unblock bluetooth || rfkill block bluetooth"
                        ]
                    }
                    onClicked: btToggle.running = true
                }

                // Microphone Module (using your script)
                ModuleButton {
                    id: micBtn
                    textFormat: Text.RichText // Required to parse the script's HTML spans

                    Timer {
                        interval: 1000; running: true; repeat: true
                    }
                }
            }
        }

        // ── Spacer ───────────────────────────────────────────────────────────
        Item { Layout.fillWidth: true }

        // ── Modules Center ───────────────────────────────────────────────────
        ModuleGroup {
            RowLayout {
                anchors.centerIn: parent

                Repeater {
                    model: Hyprland.workspaces
                    ModuleButton {
                        property bool isActive: Hyprland.focusedWorkspace == moduleData
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
                        defaultColor: isActive ? Theme.danger : Theme.fg
                        onClicked: Hyprland.dispatch("workspace" + modelData.id)
                    }
                }
            }
        }

        // ── Spacer ─────────────────────────────────────────────────────
        Item { Layout.fillWidth: true }

        // ── Modules Right ──────────────────────────────────────────────
        ModuleGroup {
            RowLayout {
                anchors.centerIn: parent
                spacing: 8

                // Keyboard Module
                ModuleButton {
                    id: kbdBtn
                    Timer {
                        interval: 1000; running: true; repeat: true
                        onTriggered: {
                            Quickshell.exec("bash ~/.config/waybar/scripts/keyboard-status.sh", (output) => {
                                let json = JSON.parse(output)
                                kbdBtn.text = json.text || ""
                            })
                        }
                    }
                }

                // Volume Module
                ModuleButton {
                    id: volBtn
                    textFormat: Text.RichText // Required for span foregrounds
                    onClicked: Quickshell.exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
                    onScrolledUp: Quickshell.exec("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+")
                    onScrolledDown: Quickshell.exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")

                    Timer {
                        interval: 1000; running: true; repeat: true
                        onTriggered: {
                            Quickshell.exec("bash ~/.config/waybar/scripts/volume.sh", (output) => {
                                let json = JSON.parse(output)
                                volBtn.text = json.text
                            })
                        }
                    }
                }
            }
        }
    }
}
