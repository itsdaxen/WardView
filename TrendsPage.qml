import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Item {
    id: root

    property string patientName: ""

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 12

        Label {
            text: qsTr("Trends")
            color: Theme.textPrimary
            font.pixelSize: 26
            font.bold: true
        }

        Label {
            text: qsTr("Patient measurements over time")
            color: Theme.textSecondary
        }

        Label {
            text: qsTr("Patient: %1").arg(root.patientName)
            color: Theme.textSecondary
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 8

            Repeater {
                model: ListModel {
                    ListElement {
                        measurementName: "Heart rate"
                        measurementValues: "72 → 76 → 78"
                        measurementUnit: "bpm"
                        measurementTimeRange: "Last 3 hours"
                        measurementDirection: "Rising"
                    }
                    ListElement {
                        measurementName: "Oxygen saturation"
                        measurementValues: "97 → 98 → 97"
                        measurementUnit: "%"
                        measurementTimeRange: "Last 3 hours"
                        measurementDirection: "Stable"
                    }
                    ListElement {
                        measurementName: "Non-invasive BP"
                        measurementValues: "121/76 → 118/74"
                        measurementUnit: "mmHg"
                        measurementTimeRange: "Last 6 hours"
                        measurementDirection: "Falling"
                    }
                }

                TrendRow {
                    required property string measurementName
                    required property string measurementValues
                    required property string measurementUnit
                    required property string measurementTimeRange
                    required property string measurementDirection

                    Layout.fillWidth: true
                    name: measurementName
                    values: measurementValues
                    unit: measurementUnit
                    timeRange: measurementTimeRange
                    direction: measurementDirection
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
