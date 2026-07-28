import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

ApplicationWindow {
    id: window

    width: 1100
    height: 760
    minimumWidth: 700
    minimumHeight: 520

    visible: true
    title: qsTr("WardView Bedside Monitor")
    color: "#f4f7f9"

    property bool isMobile: width < 820
    property int selectedVital: -1
    property string selectedVitalName: qsTr("No vital selected")

    component SectionTitle : Label {
        font.pixelSize: 20
        font.bold: true
        color: "#152536"
    }

    component StatusPill : Rectangle {
        required property string label
        property color accent: "#16794b"

        implicitWidth: pillLabel.implicitWidth + 22
        implicitHeight: 32
        radius: 16
        color: Qt.alpha(accent, 0.12)
        border.color: Qt.alpha(accent, 0.35)

        Label {
            id: pillLabel
            anchors.centerIn: parent
            text: parent.label
            color: parent.accent
            font.bold: true
            font.pixelSize: 12
        }
    }

    component InfoPanel : Rectangle {
        id: infoPanel

        required property string heading
        required property string body
        property color accent: "#2b6f8f"

        implicitHeight: 132
        radius: 8
        color: "white"
        border.color: "#d6e0e6"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 18
            spacing: 8

            Rectangle {
                Layout.preferredWidth: 36
                Layout.preferredHeight: 5
                radius: 3
                color: infoPanel.accent
            }

            Label {
                text: infoPanel.heading
                color: "#152536"
                font.bold: true
                font.pixelSize: 16
            }

            Label {
                Layout.fillWidth: true
                text: infoPanel.body
                color: "#526574"
                wrapMode: Text.WordWrap
            }
        }
    }

    Item {
        id: appContainer
        anchors.fill: parent

        Rectangle {
            id: sidebar
            color: "#e8f0f4"

            Label {
                id: brandLabel
                text: qsTr("WardView")
                color: "#17384a"
                font.pixelSize: 22
                font.bold: true
            }

            Button {
                id: overviewButton
                text: qsTr("Overview")
            }

            Button {
                id: alarmsButton
                text: qsTr("Alarms")
            }

            Button {
                id: trendsButton
                text: qsTr("Trends")
            }

            TextField {
                id: searchField
                placeholderText: qsTr("Search measurements")
                KeyNavigation.tab: heartRateCard
                KeyNavigation.priority: KeyNavigation.BeforeItem
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 18
                anchors.topMargin: 28
                spacing: 10
                visible: !window.isMobile

                LayoutItemProxy {
                    target: brandLabel
                    Layout.fillWidth: true
                    Layout.bottomMargin: 20
                }

                LayoutItemProxy {
                    target: overviewButton
                    Layout.fillWidth: true
                }

                LayoutItemProxy {
                    target: alarmsButton
                    Layout.fillWidth: true
                }

                LayoutItemProxy {
                    target: trendsButton
                    Layout.fillWidth: true
                }

                Item {
                    Layout.fillHeight: true
                }

                Label {
                    text: qsTr("CENTRAL UNIT")
                    color: "#647784"
                    font.pixelSize: 11
                    font.bold: true
                }

                LayoutItemProxy {
                    target: searchField
                    Layout.fillWidth: true
                }

                Label {
                    text: qsTr("Connected · Ward 4B")
                    color: "#16794b"
                    font.pixelSize: 12
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 7
                visible: window.isMobile

                LayoutItemProxy {
                    target: brandLabel
                    Layout.rightMargin: 8
                }

                LayoutItemProxy {
                    target: overviewButton
                }

                LayoutItemProxy {
                    target: alarmsButton
                }

                LayoutItemProxy {
                    target: trendsButton
                }
            }
        }

        Rectangle {
            id: mainArea
            color: "#f4f7f9"

            ScrollView {
                id: mainScroll
                anchors.fill: parent
                leftPadding: 24
                rightPadding: 24
                contentWidth: availableWidth
                contentHeight: contentColumn.implicitHeight
                clip: true

                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AsNeeded

                ColumnLayout {
                    id: contentColumn
                    width: mainScroll.availableWidth
                    spacing: 16

                    Item {
                        Layout.preferredHeight: 8
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 16

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 3

                            Label {
                                text: qsTr("BED 12 · ROOM 418")
                                color: "#547184"
                                font.pixelSize: 12
                                font.bold: true
                            }

                            SectionTitle {
                                text: qsTr("Alex Morgan")
                            }

                            Label {
                                text: qsTr("Adult · Patient ID 804219")
                                color: "#607482"
                            }
                        }

                        StatusPill {
                            label: qsTr("Monitoring")
                        }
                    }

                    Flow {
                        Layout.fillWidth: true
                        Layout.preferredHeight: implicitHeight
                        spacing: 8

                        StatusPill {
                            label: qsTr("ECG connected")
                        }

                        StatusPill {
                            label: qsTr("SpO₂ connected")
                        }

                        StatusPill {
                            label: qsTr("NIBP: 10 min")
                            accent: "#2b6f8f"
                        }
                    }

                    SectionTitle {
                        text: qsTr("Current vitals")
                        Layout.topMargin: 8
                    }

                    GridLayout {
                        Layout.fillWidth: true
                        columns: mainArea.width < 620 ? 1 : mainArea.width < 980 ? 2 : 3
                        columnSpacing: 14
                        rowSpacing: 14

                        VitalCard {
                            id: heartRateCard
                            name: qsTr("Heart rate")
                            value: "78"
                            unit: qsTr("bpm")
                            status: qsTr("Within limits")
                            accent: "#16794b"
                            selected: window.selectedVital === 0

                            Layout.fillWidth: true
                            Layout.minimumWidth: 0
                            Layout.preferredHeight: implicitHeight

                            onActivated: {
                                window.selectedVital = 0
                                window.selectedVitalName = name
                            }

                            KeyNavigation.tab: oxygenCard
                            KeyNavigation.backtab: searchField
                        }

                        VitalCard {
                            id: oxygenCard
                            name: qsTr("Oxygen saturation")
                            value: "97"
                            unit: "%"
                            status: qsTr("Stable signal")
                            accent: "#16794b"
                            selected: window.selectedVital === 1

                            Layout.fillWidth: true
                            Layout.minimumWidth: 0
                            Layout.preferredHeight: implicitHeight

                            onActivated: {
                                window.selectedVital = 1
                                window.selectedVitalName = name
                            }

                            KeyNavigation.tab: bloodPressureCard
                            KeyNavigation.backtab: heartRateCard
                        }

                        VitalCard {
                            id: bloodPressureCard
                            name: qsTr("Non-invasive BP")
                            value: "118/74"
                            unit: qsTr("mmHg")
                            status: qsTr("Measured 2 min ago")
                            accent: "#2b6f8f"
                            selected: window.selectedVital === 2

                            Layout.fillWidth: true
                            Layout.minimumWidth: 0
                            Layout.preferredHeight: implicitHeight

                            onActivated: {
                                window.selectedVital = 2
                                window.selectedVitalName = name
                            }

                            KeyNavigation.tab: respiratoryCard
                            KeyNavigation.backtab: oxygenCard
                        }

                        VitalCard {
                            id: respiratoryCard
                            name: qsTr("Respiratory rate")
                            value: "16"
                            unit: qsTr("/min")
                            status: qsTr("Within limits")
                            accent: "#16794b"
                            selected: window.selectedVital === 3

                            Layout.fillWidth: true
                            Layout.minimumWidth: 0
                            Layout.preferredHeight: implicitHeight

                            onActivated: {
                                window.selectedVital = 3
                                window.selectedVitalName = name
                            }

                            KeyNavigation.backtab: bloodPressureCard
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 68
                        color: "transparent"

                        Rectangle {
                            anchors.top: parent.top
                            width: parent.width
                            height: 1
                            color: "#d6e0e6"
                        }

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: 1
                            color: "#d6e0e6"
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 4
                            anchors.rightMargin: 4
                            spacing: 10

                            Rectangle {
                                Layout.preferredWidth: 8
                                Layout.preferredHeight: 8
                                radius: 4
                                color: "#d18a1b"
                            }

                            Label {
                                text: qsTr("ADVISORY")
                                color: "#8a5a15"
                                font.bold: true
                                font.pixelSize: 11
                            }

                            Label {
                                Layout.fillWidth: true
                                text: qsTr("SpO₂ probe signal was intermittent. Check placement if the value becomes unstable.")
                                color: "#526574"
                                elide: Text.ElideRight
                            }

                            Button {
                                text: qsTr("Acknowledge")
                                flat: true
                            }
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        InfoPanel {
                            Layout.fillWidth: true
                            heading: qsTr("Selected measurement")
                            body: window.selectedVital < 0
                                  ? qsTr("Select a vital card to inspect its measurement context.")
                                  : qsTr("%1 details are ready. Review its limits and recent measurements.").arg(window.selectedVitalName)
                        }

                        Label {
                            Layout.fillWidth: true
                            text: qsTr("Device status · Battery 86% · Network online · Self-test passed at 07:42")
                            color: "#526574"
                        }
                    }

                    Item {
                        Layout.preferredHeight: 4
                    }
                }
            }
        }

        RowLayout {
            anchors.fill: parent
            spacing: 0
            visible: !window.isMobile

            LayoutItemProxy {
                target: sidebar
                Layout.minimumWidth: 226
                Layout.preferredWidth: 226
                Layout.maximumWidth: 226
                Layout.fillHeight: true
            }

            LayoutItemProxy {
                target: mainArea
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 0
            visible: window.isMobile

            LayoutItemProxy {
                target: sidebar
                Layout.fillWidth: true
                Layout.preferredHeight: 68
            }

            LayoutItemProxy {
                target: mainArea
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
