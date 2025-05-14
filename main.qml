import QtQuick 6.5
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0

// import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import "Components"
import "LayoutManager.js" as Responsive

ApplicationWindow {
    id: root
    width: 1920
    height: 1200
    // width: 1500 * 0.8
    // height: 1200 * 0.8
    // maximumHeight: height * 0.6
    // minimumHeight: height * 0.6
    // maximumWidth: width * 0.6
    // minimumWidth: width * 0.6
    property real carX: 350
    property real carY: 250

    visible: true
    title: qsTr("Car Dachboard V1")
    onWidthChanged: {
        if (adaptive)
            adaptive.updateWindowWidth(root.width)
    }

    onHeightChanged: {
        if (adaptive)
            adaptive.updateWindowHeight(root.height)
    }
    property var adaptive: new Responsive.AdaptiveLayoutManager(root.width,
                                                                root.height,
                                                                root.width,
                                                                root.height)

    FontLoader {
        id: uniTextFont
        source: "Fonts/Unitext Regular.ttf"
    }

    background: Loader {
        anchors.fill: parent
        sourceComponent: Style.mapAreaVisible ? backgroundRect : backgroundImage
    }

    Header {
        z: 99
        id: headerLayout
    }

    footer: Footer {
        id: footerLayout
        onOpenLauncher: launcher.open()
        onOpenCamera: camera.open()
        onOpenBattery: battery.open()
    }

    TopLeftButtonIconColumn {
        z: 99
        anchors.left: parent.left
        anchors.top: headerLayout.bottom
        anchors.leftMargin: 18
    }

    RowLayout {
        id: mapLayout
        visible: Style.mapAreaVisible
        spacing: 0
        anchors {
              top: headerLayout.bottom
              bottom: footerLayout.top
              left: parent.left
              right: parent.right
          }

        // الصورة اللي على الشمال (sidebar)
        Item {
            id : sidebar_left
            Layout.preferredWidth: 620
            Layout.fillHeight: true
            Image {
                anchors.centerIn: parent
                source: Style.isDark ? "icons/light/sidebar.png" : "icons/dark/sidebar-light.png"
            }
        }

        // الخريطة على اليمين
        Item {
            id: mapImageContainer
            Layout.fillWidth: true
            Layout.fillHeight: true

            Image {
                id: mapImage
                anchors.fill: parent
                // fillMode: Image.Stretch
                fillMode: Image.PreserveAspectFit
                source: "carla_map.png"
            }
            Image {
            id: carIcon
            source: "Map/CarMarker.png" // حط هنا أيقونة السيارة اللي عندك
            width: 60
            height: 60
            anchors.centerIn: undefined
            x: carX
            y: carY
        }
        }
    }
    Connections {
            target: backend
            function onPositionChanged(x, y) {
                carX = x
                carY = y
            }
        }


    CameraPage {
        id: camera
        x : 620
        y : 50
    }

    LaunchPadControl {
        id: launcher
        y: (root.height - height) / 2 + (footerLayout.height)
        x: (root.width - width) / 2
        onOpenCamera: camera.open()
        onOpenBattary: battery.open()

    }
    BatteryPage {
        id: battery
        y: 70
        x: 100
    }

    Component {
        id: backgroundRect
        Rectangle {
            color: "#171717"
            anchors.fill: parent
        }
    }

    Component {
        id: backgroundImage
        Image {
            source: Style.getImageBasedOnTheme()
            Icon {
                icon.source: Style.isDark ? "icons/car_action_icons/dark/lock.svg" : "icons/car_action_icons/lock.svg"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -350
                anchors.horizontalCenterOffset: 37
            }

            Icon {
                icon.source: Style.isDark ? "icons/car_action_icons/dark/Power.svg" : "icons/car_action_icons/Power.svg"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -77
                anchors.horizontalCenterOffset: 550
            }

            ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -230
                anchors.horizontalCenterOffset: 440

                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    text: "Trunk"
                    font.family: "Inter"
                    font.pixelSize: 14
                    font.bold: Font.DemiBold
                    color: Style.black20
                }
                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    text: "Open"
                    font.family: "Inter"
                    font.pixelSize: 16
                    font.bold: Font.Bold
                    color: Style.isDark ? Style.white : "#171717"
                }
            }

            ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -180
                anchors.horizontalCenterOffset: -350

                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    text: "Frunk"
                    font.family: "Inter"
                    font.pixelSize: 14
                    font.bold: Font.DemiBold
                    color: Style.black20
                }
                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    text: "Open"
                    font.family: "Inter"
                    font.pixelSize: 16
                    font.bold: Font.Bold
                    color: Style.isDark ? Style.white : "#171717"
                }
            }
        }
    }



}
