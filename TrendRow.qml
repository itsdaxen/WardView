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
    color: "white"
    border.color: "#d6e0e6"

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 8

        ColumnLayout {
            spacing: 3

            Label {
                text: root.name
                color: "#152536"
                font.bold: true
            }

            Label {
                text: root.timeRange
                color: "#526574"
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
                    color: "#152536"
                    font.pixelSize: 18
                    font.bold: true
                }

                Label {
                    text: root.unit
                    color: "#526574"
                }
            }

            Label {
                Layout.alignment: Qt.AlignRight
                text: root.direction
                color: "#526574"
                font.pixelSize: 12
            }
        }
    }
}
