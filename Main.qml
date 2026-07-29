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
    property string currentPage: "overview"

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
                onClicked: window.currentPage = "overview"
            }

            Button {
                id: alarmsButton
                text: qsTr("Alarms")
            }

            Button {
                id: trendsButton
                text: qsTr("Trends")
                onClicked: window.currentPage = "trends"
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

            Loader {
                id: overviewLoader

                anchors.fill: parent
                active: window.currentPage === "overview"
                source: "OverviewPage.qml"

                onLoaded: item.previousTabItem = searchField
            }

            Loader {
                id: trendsLoader

                anchors.fill: parent
                active: window.currentPage === "trends"
                source: "TrendsPage.qml"

                onLoaded: item.patientName = "Alex Morgan"
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
