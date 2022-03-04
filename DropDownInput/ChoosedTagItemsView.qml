import QtQuick 2.9
Flow{
    id:totalChoosed
    spacing:3
    padding: 4
    property var tagChoosed:[];
    signal deleteRequested(string nameDeleted)

    signal addedNewChoosedTag(string name)
    signal deletedChoosedTag(string name)

    Item
    {
        id:privateProps
        property ListModel tags: privTags;
        ListModel {
            id:privTags
            onCountChanged: {
                for(var i = totalChoosed.tagChoosed.length; i !== 0; --i)
                    totalChoosed.tagChoosed.pop();
                for(var j = 0; j < privateProps.tags.count; ++j)
                    totalChoosed.tagChoosed.push(privateProps.tags.get(i).name);
            }
        }

        function find(model, criteria) {
            for(var i = 0; i < model.count; ++i) if (model.get(i).name === criteria) return i;
            return null;
        }
    }

    function push(itemText)
    {
        var found = privateProps.find(privateProps.tags, itemText);
        if(found === null){
            privateProps.tags.append({'name': itemText });
            totalChoosed.addedNewChoosedTag(itemText);
        }
        else
            console.log("Exist!");
    }
    function pop(itemText)
    {
        var found = privateProps.find(privateProps.tags, itemText);
        if(found !== null){
            privateProps.tags.remove(found);
            totalChoosed.deletedChoosedTag(itemText);
        }
        else
            console.log("Not exist!");
    }

    Repeater{
        id:tagRepeater
        model:privateProps.tags
        ChoosedTagItem{
            tagItemName:  name
            onDeleteRequested: {
                console.log(tagItemName);
                totalChoosed.deleteRequested(tagItemName);
            }
        }
    }
    onDeleteRequested:(nameDeleted)=> {
                          totalChoosed.pop(nameDeleted)
                      }
}
