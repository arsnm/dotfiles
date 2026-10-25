pragma Singleton
import QtQuick

QtObject {
    readonly property color bg: "#181818"
    readonly property color bgHover: "#282828"

    readonly property color fg: "#ffdd33"
    readonly property color active: "#73c936"
    readonly property color inactive: "#96a6c8"
    readonly property color danger: "#f43841"

    readonly property color micActive: "#9e96c7"
    readonly property color volMuted: danger
    readonly property color volLow: "#303540"
    readonly property color volMid: "#565f73"
    readonly property color volHigh: inactive
    readonly property color volVeryHigh: danger
}
