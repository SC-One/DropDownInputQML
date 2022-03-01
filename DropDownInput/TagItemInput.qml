import QtQuick 2.9
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.3
Rectangle {
    id:rootRectInput
    property string currentText: editor.text
    property var tagChoosed: choosedView.tagChoosed;
    property bool activeSuggestions: editor.focus;
    radius:10
    color: "#2d2d2d"
    layer.enabled: editor.focus
    layer.effect: Glow {
        radius: 14
        samples: 30
        color: "#4986b3"
        source: rootRectInput
    }
    ChoosedTagItemsView {
        id:choosedView
        anchors.fill: parent;
        TextInput{
            id:editor
            maximumLength: 20
            color: "#d7fce1"
            onAccepted: {
                choosedView.push(editor.text);
            }
            onFocusChanged: {
                if(editor.text !== "")
                choosedView.pop(editor.text);
            }

            font.pointSize: 14;
        }
    }
    activeFocusOnTab: true
    onFocusChanged: {
        if(focus)
            editor.focus=focus;
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            editor.focus=true;
        }
    }
}
