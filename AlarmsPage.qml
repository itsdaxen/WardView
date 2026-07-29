import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Item {
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
            text: qsTr("Patient alarm history")
            color: Theme.textSecondary
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
