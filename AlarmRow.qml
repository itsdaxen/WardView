import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Rectangle {
    id: root

    required property int index
    required property string time
    required property string parameter
    required property string value
    required property bool acknowledged

    required property real timeColumnWidth
    required property real valueColumnWidth
    required property real actionColumnWidth

    signal selectionRequested
    signal acknowledgeRequested

    width: ListView.view.width
    height: 72
    color: Theme.surface

    RowLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16

        Label {
            Layout.preferredWidth: root.timeColumnWidth
            text: root.time
            color: Theme.textSecondary
        }

        Label {
            text: root.parameter
            color: Theme.textPrimary
            font.bold: true
        }

        Item {
            Layout.fillWidth: true
        }

        Label {
            Layout.preferredWidth: root.valueColumnWidth
            text: root.value
            color: Theme.textPrimary
            font.bold: true
        }

        Button {
            id: acknowledgeButton

            Layout.preferredWidth: root.actionColumnWidth
            text: root.acknowledged ? qsTr("Acknowledged") : qsTr("Acknowledge")
            font.bold: true
            enabled: !root.acknowledged

            contentItem: Text {
                text: acknowledgeButton.text
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                color: root.acknowledged ? Theme.success : Theme.info
            }

            onClicked: root.acknowledgeRequested()
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        height: 1
        color: Theme.border
        visible: root.index < ListView.view.count - 1
    }

    TapHandler {
        onTapped: root.selectionRequested()
    }
}
