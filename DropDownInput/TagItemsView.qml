import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ScrollView{
    id:root
    clip:true
    required property var model;
    signal tagItemSelected(string name);
    ScrollBar.vertical.policy: ScrollBar.AsNeeded
    background: Rectangle {
        id:backContent
        color:"#4f4f4f"
        radius: 8
        border.color: "gray"
        border.width: 1
        property bool stateVisible: backContent.visible
        states: [
            State { when: backContent.stateVisible;
                PropertyChanges {   target: backContent; opacity: 1.0    }
            },
            State { when: !backContent.stateVisible;
                PropertyChanges {   target: backContent; opacity: 0.0    }
            }
        ]
        transitions: Transition {
            NumberAnimation { property: "opacity"; duration: 270}
        }
    }

    Flickable{
        id:content
        contentHeight: flow.height
        width: parent.width
        //        height: 800
        //        anchors.fill: parent
        Flow{
            id:flow
            width:parent.width
            padding: 8
            spacing:10
            function mar(){
                var rowCount = parent.width / (flow.children[0].width + flow.spacing);
                if(rowCount> flow.children.length){
                    rowCount = flow.children.length
                }
                rowCount = parseInt(rowCount)
                var rowWidth = rowCount * flow.children[0].width + (rowCount - 1) * flow.spacing
                print(flow.height)
                return (parent.width - rowWidth) / 2

            }
            leftPadding: mar()
            rightPadding: mar()
            Repeater
            {
                id:repeater
                model: root.model
                TagItem{
                    nameText: Name;
                    descriptionText: Description;
                    linkText: Link;
                    onClicked: {
                        root.tagItemSelected(nameText);
                    }
                }
            }
        }
    }
}
