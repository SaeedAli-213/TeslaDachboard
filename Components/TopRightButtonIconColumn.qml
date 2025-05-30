import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0

ColumnLayout {
    spacing: 3
    // Icon {
    //     Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    //     icon.source: "../light-icons/Headlight2.svg"
    // }
    // Icon {
    //     Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    //     icon.source: "../light-icons/Property 1=Default.svg"
    // }
    Icon {
        id :headLight
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        icon.source: "../light-icons/Icons/headlight/white.svg"
    }
    Icon {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        icon.source: "../light-icons/Seatbelt.svg"
    }
}
