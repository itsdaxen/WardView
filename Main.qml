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
    color: Theme.pageBackground

    property bool isMobile: width < 820
    property string currentPage: "overview"

    Item {
        id: appContainer
        anchors.fill: parent

        Sidebar {
            id: sidebar

            mobile: window.isMobile
            onPageRequested: page => window.currentPage = page
        }

        Rectangle {
            id: mainArea
            color: Theme.pageBackground

            Loader {
                id: overviewLoader

                anchors.fill: parent
                active: window.currentPage === "overview"
                source: "OverviewPage.qml"

                onLoaded: item.previousTabItem = sidebar.searchInput
            }

            Loader {
                id: trendsLoader

                anchors.fill: parent
                active: window.currentPage === "trends"
                source: "TrendsPage.qml"

                onLoaded: item.patientName = "Alex Morgan"
            }

            Loader {
                id: alarmsLoader

                anchors.fill: parent
                active: window.currentPage === "alarms"
                source: "AlarmsPage.qml"
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
