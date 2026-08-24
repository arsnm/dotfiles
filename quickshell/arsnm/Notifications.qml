import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications

PanelWindow {
    anchors { top: true; right: true }
    margins { top: 50; right: 10 }
    width: 300
    color: "transparent"

    ListView {
        id: notifList
        width: parent.width
        height: contentHeight
        spacing: 8
        model: NotificationServer.notifications

        delegate: Rectangle {
            width: parent.width
            height: layout.implicitHeight + 16
            radius: 2

            property color urgencyColor: {
                if (modelData.urgency === Notification.Critical) return Theme.danger
                if (modelData.urgency === Notification.Low) return Theme.inactive
                return Theme.fg
            }

            color: Theme.bg
            border.color: urgencyColor
            border.width: 1

            ColumnLayout {
                id: layout
                anchors.fill: parent
                anchors.margins: 8

                Text {
                    Layout.fillWidth: true
                    text: "<b><u>" + modelData.appName + "</u> : " + modelData.summary + "</b>"
                    color: parent.urgencyColor
                    font.family: "JetBrainsMono Nerd Font Mono"
                    font.pixelSize: 14
                    textFormat: Text.RichText
                }

                Text {
                    Layout.fillWidth: true
                    text: modelData.body
                    color: parent.urgencyColor
                    font.family: "JetBrainsMono Nerd Font Mono"
                    font.pixelSize: 14
                    wrapMode: Text.WordWrap
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: modelData.close()
            }
        }
    }
}
