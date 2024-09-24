import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "favoritesPage"
    allowedOrientations: Orientation.All

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

        header: PageHeader { title: qsTr("Избранные") }


       model: ListModel { id: dataModel }
       delegate: ListItem {
            contentHeight: im.height + 80
            Column{
                Label {
                   text: username
                }
                Label {
                   text: title
                }
                Image {
                    id: im
                    source: image
                    width: sourceSize.width
                    height: sourceSize.height
                }
             }
            menu: ContextMenu {
                MenuItem {
                    text: "Убрать из избранного"
                    onClicked: {
                        dao.deleteImage(id);
                        selectImages();
                    }
                }
                MenuItem {
                    text: "Скопировать Url"
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

    Component.onCompleted: {
        selectImages();
    }
}
