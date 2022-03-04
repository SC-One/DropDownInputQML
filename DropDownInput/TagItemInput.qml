import QtQuick 2.9
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import ir.hcoding.models 1.0
import QtQuick.Dialogs 1.3
ScrollView {
    id:rootRectInput
    height: 50
    clip:true
    contentItem.clip: true
    implicitHeight: height
    ScrollBar.horizontal.policy: ScrollBar.AsNeeded
    ScrollBar.vertical.policy: ScrollBar.AsNeeded
    property bool multiLineTags: true  // ture-> tags will be in multiple line (width fixed)  , false-> tags will be in one line (height fixed)
    property var originModel:;
    property string currentText: editor.text
    property var tagChoosed: choosedView.tagChoosed;
    property bool activeSuggestions: editor.focus;
    background: Rectangle{
        radius:10
        color: "#2d2d2d"
    }
    layer.enabled: editor.focus
    layer.effect: Glow {
        radius: 14
        samples: 30
        color: "#4986b3"
        source: rootRectInput
    }
    function addToEditor(tagName){
        editor.text = tagName;
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            rootRectInput.focus=true;
        }
    }

    ChoosedTagItemsView {
        id:choosedView
        width: rootRectInput.multiLineTags ? rootRectInput.width : rootRectInput.childrenRect.width * 1.5;
        TagEditor{
            MessageDialog {
                id: messageDialog
                title: "Error"
                text: "The tag was not exist in tags!"
                onAccepted: {
                    messageDialog.close();
                }
            }
            id:editor
            onTextChanged: text= text.replace(/\s+/g,'')
            function addTextToTags(){
                if(editor.text.length == 0)
                    return;
                if(originModel.contains(editor.text))
                {
                    choosedView.push(editor.text)
                    editor.text = "";
                }
                else{
                    messageDialog.open();
                }
            }

            onAccepted: addTextToTags();
            focus: rootRectInput.focus;
        }
    }
    activeFocusOnTab: true
}
