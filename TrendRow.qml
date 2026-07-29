import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Rectangle {
    id: root

    required property string name
    required property string values
    required property string unit
    required property string timeRange
    required property string direction

    implicitHeight: 78
    radius: 8
    color: Theme.surface
    border.color: Theme.border

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 8

        ColumnLayout {
            spacing: 3

            Label {
                text: root.name
                color: Theme.textPrimary
                font.bold: true
            }

            Label {
                text: root.timeRange
                color: Theme.textSecondary
                font.pixelSize: 12
            }
        }

        Item {
            Layout.fillWidth: true
        }

        ColumnLayout {
            spacing: 3

            RowLayout {
                Layout.alignment: Qt.AlignRight
                spacing: 6

                Label {
                    text: root.values
                    color: Theme.textPrimary
                    font.pixelSize: 18
                    font.bold: true
                }

                Label {
                    text: root.unit
                    color: Theme.textSecondary
                }
            }

            Label {
                Layout.alignment: Qt.AlignRight
                text: root.direction
                color: Theme.textSecondary
                font.pixelSize: 12
            }
        }
    }
}
