import QtQuick 2.0

Item {

    TextEdit{
        id: clipboard
        visible: false
    }

    function copyText(txt){
        clipboard.text = txt
        clipboard.selectAll()
        clipboard.copy()
    }
}
