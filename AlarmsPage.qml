import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Item {
    id: root

    property Item previousTabItem

    readonly property real timeColumnWidth: 150
    readonly property real valueColumnWidth: 150
    readonly property real actionColumnWidth: 130

    onPreviousTabItemChanged: {
        if (previousTabItem)
            previousTabItem.KeyNavigation.tab = showResolvedSwitch;
    }

    AlarmModel {
        id: cppAlarmModel
    }

    AlarmProxyModel {
        id: cppAlarmProxyModel

        sourceModel: cppAlarmModel
        showResolved: false
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

        RowLayout {
            Layout.fillWidth: true

            Label {
                Layout.fillWidth: true
                text: qsTr("Patient alarm history · %1 records").arg(alarmList.count)
                color: Theme.textSecondary
            }

            Switch {
                id: showResolvedSwitch

                text: qsTr("Show resolved")
                checked: cppAlarmProxyModel.showResolved
                activeFocusOnTab: true
                KeyNavigation.backtab: root.previousTabItem
                KeyNavigation.tab: alarmList

                onToggled: cppAlarmProxyModel.showResolved = checked
            }
        }

        ListView {
            id: alarmList

            Layout.fillWidth: true
            Layout.fillHeight: true

            currentIndex: -1

            keyNavigationEnabled: true
            highlightFollowsCurrentItem: true
            KeyNavigation.backtab: showResolvedSwitch
            activeFocusOnTab: true

            onActiveFocusChanged: {
                if (activeFocus && currentIndex < 0 && count > 0)
                    currentIndex = 0;
            }

            model: cppAlarmProxyModel
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
                        Layout.preferredWidth: root.timeColumnWidth
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
                        Layout.preferredWidth: root.valueColumnWidth
                        text: qsTr("Value")
                        color: Theme.textMuted
                        font.bold: true
                    }

                    Item {
                        Layout.preferredWidth: root.actionColumnWidth
                    }
                }
            }

            delegate: AlarmRow {
                timeColumnWidth: root.timeColumnWidth
                valueColumnWidth: root.valueColumnWidth
                actionColumnWidth: root.actionColumnWidth

                onSelectionRequested: {
                    alarmList.currentIndex = index;
                    alarmList.forceActiveFocus();
                }

                onAcknowledgeRequested: {
                    cppAlarmProxyModel.setData(cppAlarmProxyModel.index(index, 0), true,
                                               AlarmModel.AcknowledgedRole);
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
