import QtQuick 2.0
import Sailfish.Silica 1.0
import custom.Counter 1.0
import custom.Network 1.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    Dao{ id: dao }

    Counter {
        id: counter
        count: 15
    }

    CopyUtil{ id: copyUtil }

    Network {
        id: network
        onAnswerChanged: {
            var data = JSON.parse(network.answer);
            dataModel.clear();
            for (var i in data) {
                var a = {
                    id:data[i].id,
                    url:data[i].url,
                    username:data[i].username,
                    title:data[i].title,
                    image: data[i].image
                };
                console.log(data[i].image)
                dataModel.append(a);
            }
        }
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
            height: header.height + mainColumn.height + searchArea.height + fButton.height + Theme.paddingLarge * 2
            PageHeader {
                id: header
                objectName: "pageHeader"
                title: qsTr("GiphyBeagle")
                extraContent.children: [
                IconButton {
                    objectName: "aboutButton"
                    icon.source: "image://theme/icon-m-about"
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                }]

                Column{
                    id: mainColumn
                    anchors{
                        top: header.bottom
                        margins: 20
                    }
                    width: parent.width
                    spacing: Theme.paddingLarge
                    TextArea {
                        id: searchArea
                        width: parent.width
                        placeholderText: "Поиск"
                        label: "Поиск"
                        text: "cat"
                    }
                    Row{
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            top: searchArea.bottom
                            left: parent
                            right: parent
                        }
                        Button {
                            anchors.margins: 20
                            id:fButton
                            text: "Найти"
                            onClicked: network.httpConnect(searchArea.text)
                        }
                        Button {
                            anchors.margins: 20
                            id:favButton
                            text: "Избранные"
                            onClicked: pageStack.push(Qt.resolvedUrl("FavoritesPage.qml"))
                        }
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
                Image {
                    id: im
                    source: image
                    width: sourceSize.width
                    height: sourceSize.height
                }
             }
            menu: ContextMenu {
                MenuItem {
                    text: "Добавить в избранное"
                    onClicked: {
                        dao.insertImage(id, url, username, title, image);
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

}
