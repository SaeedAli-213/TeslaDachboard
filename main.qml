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
    title: qsTr("Car Dachboard V2")
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
        // anchors.top: headerLayout.bottom
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 25
    }
    TopRightButtonIconColumn {
        z: 99
        anchors.right: parent.right
        // anchors.top: headerLayout.bottom
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 25
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

        Item {
            id : sidebar_left
            Layout.preferredWidth: 620
            Layout.fillHeight: true
            Image {
                anchors.centerIn: parent
                source: Style.isDark ? "icons/light/sidebar.png" : "icons/dark/sidebar-light.png"
            }
        }

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
            source: "Map/CarMarker.png"
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
            source:"icons/dark/Car.jpg"
            Image {
                id: topBar
                width: 1357
                source: "icons/top_header_icons/Vector70.svg"

                anchors{
                    top: parent.top
                    topMargin: 50
                    horizontalCenter: parent.horizontalCenter
                }
            }
            // source: Style.getImageBasedOnTheme()
            Icon {
                icon.source: Style.isDark ? "icons/car_action_icons/dark/lock.svg" : "icons/car_action_icons/lock.svg"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -200
                anchors.horizontalCenterOffset: 220
            }

            Icon {
                icon.source: Style.isDark ? "icons/car_action_icons/dark/Power.svg" : "icons/car_action_icons/Power.svg"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -180
                anchors.horizontalCenterOffset: -280
            }

            ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -200
                anchors.horizontalCenterOffset: 400

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
                anchors.horizontalCenterOffset: -480

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
    // Gauge {
    //     id: speedLabel
    //     width: 450
    //     height: 450
    //     property bool accelerating
    //     value: accelerating ? maximumValue : 0
    //     maximumValue: 250

    //     anchors.top: parent.top
    //     anchors.topMargin:Math.floor(parent.height * 0.25)
    //     anchors.horizontalCenter: parent.horizontalCenter

    //     Component.onCompleted: forceActiveFocus()

    //     Behavior on value { NumberAnimation { duration: 1000 }}

    //     Keys.onSpacePressed: accelerating = true
    //     Keys.onReleased: {
    //         if (event.key === Qt.Key_Space) {
    //             accelerating = false;
    //             event.accepted = true;
    //         }else if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
    //             radialBar.accelerating = false;
    //             event.accepted = true;
    //         }
    //     }

    //     Keys.onEnterPressed: radialBar.accelerating = true
    //     Keys.onReturnPressed: radialBar.accelerating = true
    // }





}
