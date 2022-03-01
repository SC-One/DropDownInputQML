import QtQuick 2.9
import QtQuick.Layouts 1.3
Rectangle {
    id:root
    signal deleteRequested()
    property string tagItemName: "NaN"
    color:"#3d4951"
    radius:5
    width:childrenRect.width
    height:childrenRect.height
    RowLayout{
        spacing: 1
        StandardRectangleLayout{
            Layout.alignment: Qt.AlignLeft
            Text {
                id: name
                color:"#99bdb3"
                anchors.centerIn: parent
                text: root.tagItemName
            }
        }
        StandardRectangleLayout{
            id:closeButton
            radius:4
            Layout.alignment: Qt.AlignRight
            Text {
                id: closeText
                text: qsTr("✖")
                anchors.centerIn: parent
                font.pointSize: 17;

            }
        }
    }
}
