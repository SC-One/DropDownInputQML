import QtQuick 2.0
import QtQuick.Layouts 1.3
Rectangle {
    id:rootTagItem
    property var info;
    color:"gray"
    radius: 4
    signal clicked()
    signal selected()
    onFocusChanged: {
        if(focus)
        {
            rootTagItem.color.a *= 0.5;
        }
        else{
            rootTagItem.color = "gray";
        }
        selected();
    }

    ColumnLayout{
        anchors.fill: rootTagItem
        spacing: 2
        Text {
            id: title
            Layout.fillWidth: true
            text: qsTr("title")
            font.bold: true
            horizontalAlignment: Qt.AlignHCenter
        }
        Text {
            id: description
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("description:") + " bla bla bla bla bla bla bla google bla bla bla bla bla bla bla"
        }
        Text {
            id: hyperLink
            Layout.fillWidth: true
            text: '<html><style type="text/css"></style><a href="http://google.com">google</a></html>'
            onLinkActivated: Qt.openUrlExternally(link)
        }
    }
    MouseArea{
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            console.log("Clicked Item");
            clicked();
        }
    }
}
