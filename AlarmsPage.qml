import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Item {
    id: root

    property Item previousTabItem

    onPreviousTabItemChanged: {
        if (previousTabItem)
            previousTabItem.KeyNavigation.tab = alarmList;
    }

    ListModel {
        id: alarmModel

        ListElement {
            time: "14:32"
            parameter: "SpO₂"
            message: "Low oxygen saturation"
            value: "88 %"
            priority: "High"
            active: true
            acknowledged: false
        }

        ListElement {
            time: "14:18"
            parameter: "ECG"
            message: "Lead disconnected"
            value: "Lead II"
            priority: "Medium"
            active: false
            acknowledged: true
        }

        ListElement {
            time: "13:54"
            parameter: "Heart rate"
            message: "High heart rate"
            value: "128 bpm"
            priority: "High"
            active: false
            acknowledged: true
        }

        ListElement {
            time: "13:27"
            parameter: "NIBP"
            message: "High systolic pressure"
            value: "154/92 mmHg"
            priority: "Medium"
            active: false
            acknowledged: true
        }

        ListElement {
            time: "12:46"
            parameter: "Respiratory rate"
            message: "Low respiratory rate"
            value: "8 /min"
            priority: "High"
            active: false
            acknowledged: true
        }

        ListElement {
            time: "12:11"
            parameter: "SpO₂"
            message: "Probe disconnected"
            value: "No signal"
            priority: "Medium"
            active: false
            acknowledged: true
        }

        ListElement {
            time: "11:38"
            parameter: "Heart rate"
            message: "Low heart rate"
            value: "46 bpm"
            priority: "High"
            active: false
            acknowledged: true
        }

        ListElement {
            time: "10:52"
            parameter: "ECG"
            message: "Signal quality poor"
            value: "Lead III"
            priority: "Low"
            active: false
            acknowledged: true
        }

        ListElement {
            time: "10:16"
            parameter: "NIBP"
            message: "Measurement unsuccessful"
            value: "Retry"
            priority: "Low"
            active: false
            acknowledged: true
        }

        ListElement {
            time: "09:41"
            parameter: "Respiratory rate"
            message: "High respiratory rate"
            value: "31 /min"
            priority: "Medium"
            active: false
            acknowledged: true
        }

        ListElement {
            time: "09:03"
            parameter: "SpO₂"
            message: "Low oxygen saturation"
            value: "89 %"
            priority: "High"
            active: false
            acknowledged: true
        }

        ListElement {
            time: "08:24"
            parameter: "ECG"
            message: "Lead disconnected"
            value: "Lead V"
            priority: "Medium"
            active: false
            acknowledged: true
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 12

        Label {
            text: qsTr("Alarms")
            color: Theme.textPrimary
            font.pixelSize: 26
            font.bold: true
        }

        Label {
            text: qsTr("Patient alarm history · %1 records").arg(alarmModel.count)
            color: Theme.textSecondary
        }

        ListView {
            id: alarmList

            Layout.fillWidth: true
            Layout.fillHeight: true

            currentIndex: -1

            keyNavigationEnabled: true
            highlightFollowsCurrentItem: true
            KeyNavigation.backtab: root.previousTabItem
            activeFocusOnTab: true

            onActiveFocusChanged: {
                if (activeFocus && currentIndex < 0 && count > 0)
                    currentIndex = 0;
            }

            model: alarmModel
            spacing: 0
            clip: true

            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
            }

            highlight: Rectangle {
                z: 2
                color: "transparent"
                border.width: 2
                border.color: Theme.info
            }

            highlightMoveDuration: 100

            headerPositioning: ListView.OverlayHeader
            header: Rectangle {
                width: alarmList.width
                height: 40
                z: 3
                color: Theme.pageBackground

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 16
                    anchors.rightMargin: 16
                    spacing: 16

                    Label {
                        Layout.preferredWidth: 52
                        text: qsTr("Time")
                        color: Theme.textMuted
                        font.bold: true
                    }

                    Label {
                        text: qsTr("Measurement")
                        color: Theme.textMuted
                        font.bold: true
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Label {
                        text: qsTr("Value")
                        color: Theme.textMuted
                        font.bold: true
                    }
                }
            }

            delegate: Rectangle {
                required property int index
                required property string time
                required property string parameter
                required property string value

                width: ListView.view.width
                height: 72
                color: Theme.surface

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 16

                    Label {
                        Layout.preferredWidth: 52
                        text: time
                        color: Theme.textSecondary
                    }

                    Label {
                        text: parameter
                        color: Theme.textPrimary
                        font.bold: true
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Label {
                        text: value
                        color: Theme.textPrimary
                        font.bold: true
                    }
                }

                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom

                    height: 1
                    color: Theme.border
                    visible: index < alarmList.count - 1
                }

                TapHandler {
                    onTapped: {
                        alarmList.currentIndex = index;
                        alarmList.forceActiveFocus();
                    }
                }
            }

            footer: Label {
                width: alarmList.width
                height: 44
                text: qsTr("%1 alarm records").arg(alarmList.count)
                color: Theme.textMuted
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
