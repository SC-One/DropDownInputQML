import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ScrollView{
    id:root
    required property var model;
    Rectangle{
        anchors.fill: parent
        color:"black"
        radius: 5
        Flow{
            id:flow
            anchors.fill: parent
            padding: 4
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
                }
            }
        }
    }
}
