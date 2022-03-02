import QtQuick 2.0
import QtQuick.Controls 2.5
TextField{
    id:editor
    maximumLength: 20
    //TODO implement navigating between choosed tags
    signal leftKey()
    signal rightKey()
    signal leftDelete()
    signal rightDelete()
    color: "#d7fce1"
    font.pointSize: 14;
    placeholderText:"Insert a tag"
    background: Rectangle{
        color:"transparent";
        border.color: "transparent"
    }
}
