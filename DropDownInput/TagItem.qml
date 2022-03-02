import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    id:rootTagItem
    implicitWidth: 200
    implicitHeight:100
    clip:true
    signal clicked()

    property string nameText:           "None";
    property string descriptionText:    "None";
    property string linkText:           "None";

    onDescriptionTextChanged: {
        description.text = descriptionText.split(0,40)+" ...";
    }

    color:"gray"
    radius: 1
    MouseArea{
        id: linkAreaName
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
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
            color:"#707070"
//            Layout.fillWidth: true
            width:rootTagItem.width
            Text {
                id: name
                font.bold: true
                color:"white"
                font.pointSize: 14;
                anchors.centerIn: parent
                text: rootTagItem.nameText
            }

        }

        StandardRectangleLayout{
//            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                id: description
                color:"white"
                wrapMode: Text.Wrap
                width:rootTagItem.width
                font.pointSize: 10;
            }
        }
        StandardRectangleLayout{
//            Layout.fillWidth: true
            width:rootTagItem.width
            Text {
                id: hyperLink
                text: rootTagItem.linkText
                linkColor: "#DBB2FF"
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }


    property bool stateVisible: rootTagItem.visible
    states: [
        State { when: rootTagItem.stateVisible;
            PropertyChanges {   target: rootTagItem; opacity: 1.0    }
        },
        State { when: !rootTagItem.stateVisible;
            PropertyChanges {   target: rootTagItem; opacity: 0.0    }
        }
    ]
    transitions: Transition {
        NumberAnimation { property: "opacity"; duration: 400}
    }
}
