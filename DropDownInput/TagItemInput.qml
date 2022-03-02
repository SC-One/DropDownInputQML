import QtQuick 2.9
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import ir.hcoding.models 1.0
 import QtQuick.Dialogs 1.3
ScrollView {
    id:rootRectInput
    implicitHeight: 50
    function addToEditor(tagName){
        editor.text = tagName;
    }

    property var originModel:;
    property string currentText: editor.text
    property var tagChoosed: choosedView.tagChoosed;
    property bool activeSuggestions: editor.focus;
    MouseArea{
        anchors.fill: parent
        onClicked: {
            rootRectInput.focus=true;
            mouse.accepted=false;
        }
    }
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
    Flickable{
        id:content
        contentHeight: choosedView.height
        width: parent.width
        ChoosedTagItemsView {
            id:choosedView
            anchors.fill: parent;
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
    }
    activeFocusOnTab: true
}
