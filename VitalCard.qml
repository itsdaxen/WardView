import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

Rectangle {
    id: root

    required property string name
    required property string value
    required property string unit
    required property string status
    required property color accent
    property bool selected: false

    activeFocusOnTab: true

    signal activated

    implicitHeight: 150
    radius: 8
    color: selected ? "#edf6fb" : hoverHandler.hovered ? "#f7fafb" : "white"
    border.width: selected || activeFocus ? 2 : 1
    border.color: selected || activeFocus ? "#2b6f8f" : "#d6e0e6"

    Keys.onReturnPressed: root.activated()
    Keys.onEnterPressed: root.activated()
    Keys.onSpacePressed: root.activated()

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 6

        RowLayout {
            Layout.fillWidth: true

            Label {
                Layout.fillWidth: true
                text: root.name
                color: "#526574"
                font.bold: true
            }

            Rectangle {
                Layout.preferredWidth: 9
                Layout.preferredHeight: 9
                radius: 5
                color: root.accent
            }
        }

        Item {
            Layout.fillHeight: true
        }

        RowLayout {
            spacing: 7

            Label {
                text: root.value
                color: "#132b3b"
                font.pixelSize: root.value.length > 6 ? 29 : 38
                font.bold: true
            }

            Label {
                text: root.unit
                color: "#657985"
                font.pixelSize: 14
                Layout.alignment: Qt.AlignBottom
                Layout.bottomMargin: 6
            }
        }

        Label {
            text: root.status
            color: root.accent
            font.pixelSize: 12
        }
    }

    TapHandler {
        onTapped: {
            root.forceActiveFocus();
            root.activated();
        }
    }

    HoverHandler {
        id: hoverHandler
    }
}
