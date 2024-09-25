import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "favoritesPage"
    allowedOrientations: Orientation.All

    property bool searchStat: false

    Dao{id: dao}

    CopyUtil{
        id: copyUtil
    }

    SilicaListView {
        anchors{
            fill: parent
            rightMargin: 25
            leftMargin: 25
        }
        header: Column{
            anchors{
                top: parent
                left: parent
                right: parent
            }
            width: parent.width
            height: header.height + searchArea.height
            PageHeader {
                id: header
                height: header.height + searchArea.height
                title: qsTr("Favorites")
                TextField {
                    anchors{
                        top: header.bottom
                    }
                    id: searchArea
                    width: parent.width
                    placeholderText: qsTr("Search")
                    label: qsTr("Search")
                    onTextChanged: {
                        searchText(searchArea.text)
                    }
                }
            }

        }
        model: ListModel { id: dataModel }
        delegate: ListItem {
            contentHeight: im.height + 80
            Column{
                Label {
                    text: title
                }
                AnimatedImage {
                    id: im
                    source: image
                    width: sourceSize.width
                    height: sourceSize.height
                }
            }
            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Remove from favorites")
                    onClicked: {
                        dao.deleteImage(id);
                        selectImages();
                    }
                }
                MenuItem {
                    text: qsTr("Copy Url")
                    onClicked: {
                        copyUtil.copyText(image)
                    }
                }
            }
            onClicked: {
                pageStack.push("ImageDialog.qml", {"img": image, "title": title});
            }
        }
        VerticalScrollDecorator{}
    }

    function searchText(txt){
        if(txt.length > 2){
            searchImages(txt)
            searchStat = true
        } else {
            if(searchStat == true){
                searchStat = false
                selectImages()
            }
        }
    }

    function selectImages() {
        dataModel.clear();
        dao.selectImages(function (images) {
            for (var i = 0; i < images.length; i++) {
                var a = {
                    id: images.item(i).id,
                    url: images.item(i).url,
                    username: images.item(i).username,
                    title: images.item(i).title,
                    image: images.item(i).image_url
                };
                dataModel.append(a);
            }
        });
    }

    function searchImages(txt) {
        dataModel.clear();
        dao.selectImages(function (images) {
            for (var i = 0; i < images.length; i++) {
                var title = "" + images.item(i).title;
                if(title.indexOf(txt) >= 0){
                    var a = {
                        id: images.item(i).id,
                        url: images.item(i).url,
                        username: images.item(i).username,
                        title: images.item(i).title,
                        image: images.item(i).image_url
                    };
                    dataModel.append(a);
                }
            }
        });
    }

    Component.onCompleted: {
        selectImages();
    }
}
