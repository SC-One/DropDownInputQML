import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    id:rootTagItem
    implicitWidth: 200
    implicitHeight:100
    signal clicked()
    signal selected()

    property string nameText:           "None";
    property string descriptionText:    "None";
    property string linkText:           "None";

    color:"gray"
    radius: 1
    MouseArea{
        id: linkAreaName
        anchors.fill: parent
        onClicked: {
            rootTagItem.clicked();
        }
    }
    ColumnLayout{
        id:colLayout
        anchors.fill: rootTagItem
        spacing: 2
        StandardRectangleLayout{
            Layout.alignment: Qt.AlignCenter
            color:"pink"
            Layout.fillWidth: true
            Text {
                id: name
                font.bold: true
                color:"green"
                anchors.centerIn: parent
                text: rootTagItem.nameText
            }

        }

        StandardRectangleLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                id: description
                color:"white"
                text: rootTagItem.descriptionText
            }
        }
        StandardRectangleLayout{
            Layout.fillWidth: true
            Text {
                id: hyperLink
                text: rootTagItem.linkText
                linkColor: "aqua"
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }

    onFocusChanged: {
        if(focus)
        {
            rootTagItem.color.a *= 0.5;
        }
        else{
            rootTagItem.color = "gray";
        }
        rootTagItem.selected();
    }
}
