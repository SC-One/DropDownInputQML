import QtQuick 2.0
import QtQuick.Layouts 1.3
import ir.hcoding.models 1.0
Item {
    id:rootDropDown
    property string currentText: tagItemInput.currentText
    required property var originalModel;
    property bool showSuggestion: true;
    property string filterPattern : filteredTags.filterPattern
    property var tagChoosed: tagItemInput.tagChoosed;


    FilteredTags{
        id:filteredTags
        filterPattern: rootDropDown.currentText
        originalModel: rootDropDown.originalModel
    }

    ColumnLayout{
        anchors.fill: parent
        TagItemInput{
            id:tagItemInput
            Layout.fillWidth: true;
            height:45;
            originModel:filteredTags.originalModel;
        }
        /// More option like some checkbox ...
        // and etc
    }


    TagItemsView{
        visible:rootDropDown.showSuggestion & tagItemInput.activeSuggestions
        model: filteredTags;
        x:tagItemInput.x
        y:tagItemInput.height+tagItemInput.y
        width: tagItemInput.width
        height: 120
        onTagItemSelected: (name)=> {
                               tagItemInput.addToEditor(name);
                           }
    }

}
