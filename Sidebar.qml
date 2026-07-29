import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

Rectangle {
    id: root

    required property bool mobile
    readonly property alias searchInput: searchField

    signal pageRequested(string page)
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
        onClicked: root.pageRequested("overview")
    }

    Button {
        id: alarmsButton
        text: qsTr("Alarms")
    }

    Button {
        id: trendsButton
        text: qsTr("Trends")
        onClicked: root.pageRequested("trends")
    }

    TextField {
        id: searchField
        placeholderText: qsTr("Search measurements")
        KeyNavigation.priority: KeyNavigation.BeforeItem
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 18
        anchors.topMargin: 28
        spacing: 10
        visible: !root.mobile

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
        visible: root.mobile

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
