import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Item {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 12

        Label {
            text: qsTr("Trends")
            color: "#152536"
            font.pixelSize: 26
            font.bold: true
        }

        Label {
            text: qsTr("Patient measurements over time")
            color: "#526574"
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
