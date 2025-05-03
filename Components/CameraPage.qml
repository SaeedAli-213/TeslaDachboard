import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0
// import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

Popup {
    // width: 1104
    // // height: 445
    width: 1230
    height: 600 *1.4
    id : cameradis
    property bool criticalWarningVisible: false
    background: Rectangle {
        anchors.fill: parent
        radius: 9
        color: Style.alphaColor(Style.black, 0.8)
    }

    // Dashboard (Sidebar)
    // Rectangle {
    //     id: dashboard
    //     width: 200
    //     anchors.left: parent.left
    //     anchors.top: parent.top
    //     anchors.bottom: parent.bottom
    //     color: Style.black
    //     border.color: "transparent"
    //     border.width: 2

    //     Column {
    //         spacing: 35
    //         anchors.fill: parent
    //         anchors.margins: 5

    //         Text {
    //             text: "CARLA Controls"
    //             font.pixelSize: 18
    //             Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    //             font.bold: Font.DemiBold
    //             font.family: "Inter"
    //             color: Style.isDark ? Style.white : Style.black20
    //             horizontalAlignment: Text.AlignHCenter
    //             anchors.horizontalCenter: parent.horizontalCenter
    //         }
    //         CustomButton {
    //                id: myButton
    //                width: parent.width - 5
    //                height: 50
    //                iconSource: "../icons/app_icons/recording.svg" // استبدل بمسار صورتك
    //                buttonText: "Front Camera"
    //                isGlow: true
    //                onClicked: {
    //                    backend.start_front_camera()
    //                }
    //            }


    //         // Buttons
    //         // Rectangle {
    //         //     id: frontCameraButton
    //         //     width: parent.width - 20
    //         //     height: 50
    //         //     color: "#45a29e"
    //         //     border.color: "#66fcf1"
    //         //     border.width: 2
    //         //     radius: 10
    //         //     anchors.horizontalCenter: parent.horizontalCenter
    //         //     anchors.margins: 5

    //         //     Text {
    //         //         text: "Start Front Camera"
    //         //         font.pixelSize: 18
    //         //         color: "#1f2833"
    //         //         anchors.centerIn: parent
    //         //     }

    //         //     MouseArea {
    //         //         anchors.fill: parent
    //         //         onClicked: backend.start_front_camera()
    //         //     }
    //         // }
    //         CustomButton {
    //                id: myButton2
    //                width: parent.width - 5
    //                height: 50
    //                iconSource: "../icons/app_icons/recording.svg" // استبدل بمسار صورتك
    //                buttonText: "Back Camera"
    //                isGlow: true
    //                onClicked: {
    //                    backend.start_back_camera()
    //                }
    //            }

    //         // Rectangle {
    //         //     id: backCameraButton
    //         //     width: parent.width - 20
    //         //     height: 50
    //         //     color: "#45a29e"
    //         //     border.color: "#66fcf1"
    //         //     border.width: 2
    //         //     radius: 10
    //         //     anchors.horizontalCenter: parent.horizontalCenter
    //         //     anchors.margins: 5

    //         //     Text {
    //         //         text: "Start Back Camera"
    //         //         font.pixelSize: 18
    //         //         color: "#1f2833"
    //         //         anchors.centerIn: parent
    //         //     }

    //         //     MouseArea {
    //         //         anchors.fill: parent
    //         //         onClicked: backend.start_back_camera()
    //         //     }
    //         // }
    //         Timer {
    //             id: speedUpdateTimer
    //             interval: 500    // كل 500 مللي ثانية (0.5 ثانية)
    //             running: true
    //             repeat: true
    //             onTriggered: backend.fetch_vehicle_speed()
    //         }

    //         CustomButton {
    //                id: myButton3
    //                width: parent.width - 5
    //                height: 50
    //                iconSource: "../icons/app_icons/recording.svg" // استبدل بمسار صورتك
    //                buttonText: "Stop Camera"
    //                isGlow: true
    //                onClicked: {
    //                    backend.stop_front_camera();
    //                    backend.stop_back_camera();
    //                }
    //            }

    //         // Rectangle {
    //         //     id: stopCamerasButton
    //         //     width: parent.width - 20
    //         //     height: 50
    //         //     color: "#45a29e"
    //         //     border.color: "#66fcf1"
    //         //     border.width: 2
    //         //     radius: 10
    //         //     anchors.horizontalCenter: parent.horizontalCenter
    //         //     anchors.margins: 5

    //         //     Text {
    //         //         text: "Stop Cameras"
    //         //         font.pixelSize: 18
    //         //         color: "#1f2833"
    //         //         anchors.centerIn: parent
    //         //     }

    //         //     MouseArea {
    //         //         anchors.fill: parent
    //         //         onClicked: {
    //         //             backend.stop_front_camera();
    //         //             backend.stop_back_camera();
    //         //         }
    //         //     }
    //         // }


    //     }
    // }

    Rectangle {
        anchors.fill :parent

        // Main Content Area
        Rectangle {
            id: cameraFeedArea
            anchors.fill :parent
            color: Style.black10

            Image {
                id: cameraFeedImage
                anchors.fill: parent
                fillMode: Image.Stretch
                 // fillMode: Image.PreserveAspectFit
                source: ""

            }
            Column {

                spacing: 20
                anchors.left: parent.left
                anchors.margins: 10

                Text {
                    text: "_"
                    font.pixelSize: 22
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    font.bold: Font.DemiBold
                    font.family: "Inter"
                    color: Style.black10
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                CustomButton {
                       id: myButton
                       width: 200
                       height: 50
                       iconSource: "../icons/app_icons/recording.svg" // استبدل بمسار صورتك
                       buttonText: "Front Camera"
                       isGlow: true
                       onClicked: {
                           backend.start_front_camera()
                       }
                   }
                CustomButton {
                       id: myButton2
                       width: 200
                       height: 50
                       iconSource: "../icons/app_icons/recording.svg" // استبدل بمسار صورتك
                       buttonText: "Back Camera"
                       isGlow: true
                       onClicked: {
                           backend.start_back_camera()
                       }
                   }
                Timer {
                    id: speedUpdateTimer
                    interval: 500    // كل 500 مللي ثانية (0.5 ثانية)
                    running: true
                    repeat: true
                    onTriggered: backend.fetch_vehicle_speed()
                }

                CustomButton {
                       id: myButton3
                       width: 200
                       height: 50
                       iconSource: "../icons/app_icons/recording.svg" // استبدل بمسار صورتك
                       buttonText: "Stop Camera"
                       isGlow: true
                       onClicked: {
                           backend.stop_front_camera();
                           backend.stop_back_camera();
                       }
                   }
            }

             }
        // Speed Display
           Rectangle {
               id: speedDisplay
               width: 350
               height: 50
               color: Style.black20
               border.color: Style.black10
               border.width: 2
               radius: 15
               x : 20
               anchors.horizontalCenter: cameraFeedArea.horizontalCenter
               anchors.bottom: parent.bottom
               anchors.bottomMargin: 20

               Text {
                   text: "Speed: 0 km/h"
                   font.pixelSize: 32
                   color: Style.white
                   anchors.centerIn: parent
                   font.bold: true
               }
           }




    }

    Connections {
        target: backend

        function onFront_camera_frame_ready(dataUrl) {
            cameraFeedImage.source = dataUrl;
        }


        function onBack_camera_frame_ready(dataUrl) {
            cameraFeedImage.source = dataUrl;
        }

        function onVehicle_speed_updated(speed) {
            speedDisplay.children[0].text = "Speed: " + speed.toFixed(2) + " km/h";
        }
        function onCollision_warning_signal(message) {
           // warningText.text = message;
            //collisionWarning.visible = true;
            if (!criticalWarningVisible) {  // Only execute if warning is not visible
                criticalWarningVisible = true;  // Set the flag
                criticalDistanceText.text = message;
                criticalDistanceWarning.visible = true;

            // Automatically hide warning after 5 seconds
            Qt.callLater(function () {
                criticalWarningVisible.visible = false;
                criticalDistanceWarning.visible = false;
            }, 10000);
        }
        }



        function onCritical_distance_warning_signal(message) {
            if (!criticalWarningVisible) {  // Only execute if warning is not visible
                criticalWarningVisible = true;  // Set the flag
                criticalDistanceText.text = message;
                criticalDistanceWarning.visible = true;

                // Automatically hide warning after 5 seconds
                Qt.callLater(function () {
                    criticalDistanceWarning.visible = false;
                    criticalWarningVisible = false;  // Reset the flag
                }, 10000);
            }
        }
    }


}
