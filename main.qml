import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "DropDownInput/" as Comps
import ir.hcoding.models 1.0
Window {
    width: 700
    height: 500
    visible: true
    title: qsTr("DropDown Test")
    Item{
        TagItemsModel {
            // Example (original & init original data):
            id: tagListModel;
            function makeid(length) {
                var result           = '';
                var characters       = 'abcdefg1234567890';
                var charactersLength = characters.length;
                for ( var i = 0; i < length; i++ ) {
                    result += characters.charAt(Math.floor(Math.random() *
                                                           charactersLength));
                }
                return result;
            }

            Component.onCompleted: {
                var x = tagListModel.createTagItem();
                for(var i = 0; i<25;++i)
                {
                    x.name = tagListModel.makeid(12);
                    x.description = "Description: This is simple text to Show QML power.This is simple text to Show QML power.";

                    x.link = '<html><style type="text/css"></style><a href="http://hcoding.ir">HCoding</a></html>';
                    tagListModel.addTagItem(x);
                }
            }
        }
    }
    Comps.DropDownInput{
        width: parent.width * 0.7
        height: parent.height * 0.7
        anchors.centerIn:parent
        originalModel: tagListModel;
    }

    Button{text:"Exit";onClicked:{Qt.quit()}}
}
