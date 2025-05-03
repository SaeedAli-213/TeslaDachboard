import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0
// import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

Popup {
    // width: 1104
    // // height: 445
    width: 1400*1.2
    height: 600 *1.4
    background: Rectangle {
        anchors.fill: parent
        radius: 9
        color: Style.alphaColor(Style.black, 0.8)
    }
}
