import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Qt.labs.qmlmodels

Item {
    id: root

    property string patientName: ""

    property Item previousTabItem

    onPreviousTabItemChanged: {
        if (previousTabItem)
            previousTabItem.KeyNavigation.tab = trendTable;
    }

    TableModel {
        id: trendTableModel

        TableModelColumn {
            display: "time"
        }

        TableModelColumn {
            display: "heartRate"
        }

        TableModelColumn {
            display: "oxygenSaturation"
        }

        TableModelColumn {
            display: "respiratoryRate"
        }

        TableModelColumn {
            display: "nibp"
        }

        rows: [
            {
                time: "10:50",
                heartRate: 79,
                oxygenSaturation: 98,
                respiratoryRate: 16,
                nibp: "119/75"
            },
            {
                time: "10:40",
                heartRate: 78,
                oxygenSaturation: 97,
                respiratoryRate: 16,
                nibp: "118/74"
            },
            {
                time: "10:30",
                heartRate: 77,
                oxygenSaturation: 97,
                respiratoryRate: 17,
                nibp: "120/76"
            },
            {
                time: "10:20",
                heartRate: 75,
                oxygenSaturation: 98,
                respiratoryRate: 16,
                nibp: "118/74"
            },
            {
                time: "10:10",
                heartRate: 74,
                oxygenSaturation: 97,
                respiratoryRate: 15,
                nibp: "—"
            },
            {
                time: "10:00",
                heartRate: 76,
                oxygenSaturation: 97,
                respiratoryRate: 16,
                nibp: "117/73"
            },
            {
                time: "09:50",
                heartRate: 78,
                oxygenSaturation: 98,
                respiratoryRate: 17,
                nibp: "119/74"
            },
            {
                time: "09:40",
                heartRate: 77,
                oxygenSaturation: 98,
                respiratoryRate: 16,
                nibp: "118/74"
            },
            {
                time: "09:30",
                heartRate: 75,
                oxygenSaturation: 97,
                respiratoryRate: 16,
                nibp: "120/75"
            },
            {
                time: "09:20",
                heartRate: 76,
                oxygenSaturation: 97,
                respiratoryRate: 17,
                nibp: "—"
            },
            {
                time: "09:10",
                heartRate: 74,
                oxygenSaturation: 98,
                respiratoryRate: 17,
                nibp: "119/75"
            },
            {
                time: "09:00",
                heartRate: 72,
                oxygenSaturation: 98,
                respiratoryRate: 16,
                nibp: "121/76"
            }
        ]
    }

    ItemSelectionModel {
        id: trendSelectionModel
        model: trendTableModel
    }

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
                    ListElement {
                        measurementName: "Respiratory rate"
                        measurementValues: "16 → 17 → 16"
                        measurementUnit: "/min"
                        measurementTimeRange: "Last 3 hours"
                        measurementDirection: "Stable"
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

        ColumnLayout {
            Layout.fillWidth: true
            Layout.minimumHeight: 200
            spacing: 0

            HorizontalHeaderView {
                id: trendHeader

                Layout.fillWidth: true

                syncView: trendTable
                clip: true

                model: [qsTr("Time"), qsTr("HR (bpm)"), qsTr("SpO₂ (%)"), qsTr("RR (/min)"), qsTr("NIBP (mmHg)")]

                delegate: Rectangle {
                    required property string modelData

                    implicitWidth: 140
                    implicitHeight: 40
                    color: Theme.pageBackground

                    Label {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12

                        text: modelData
                        color: Theme.textSecondary
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }

            ScrollView {
                id: trendScroll

                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ScrollBar.horizontal.policy: ScrollBar.AsNeeded
                ScrollBar.vertical.policy: ScrollBar.AsNeeded

                TableView {
                    id: trendTable

                    readonly property real minimumColumnWidth: 80

                    width: Math.max(trendScroll.availableWidth, columns * minimumColumnWidth)

                    columnWidthProvider: column => {
                        return width / columns;
                    }

                    model: trendTableModel
                    clip: true

                    selectionModel: trendSelectionModel
                    keyNavigationEnabled: true
                    activeFocusOnTab: true

                    onActiveFocusChanged: {
                        if (activeFocus) {
                            trendSelectionModel.setCurrentIndex(trendTable.index(0, 0), ItemSelectionModel.NoUpdate);
                        }
                    }

                    delegate: Rectangle {
                        required property var display

                        implicitWidth: 140
                        implicitHeight: 44

                        required property bool current

                        color: current ? Theme.surfaceSelected : Theme.surface
                        border.width: 1
                        border.color: Theme.border

                        Label {
                            anchors.fill: parent
                            anchors.margins: 12

                            text: display
                            color: Theme.textPrimary
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
