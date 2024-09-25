import QtQuick 2.0
import Sailfish.Silica 1.0
import custom.Network 1.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    Dao{ id: dao }
    CopyUtil{ id: copyUtil }
    RandUtil{ id: randUtil}

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
            height: header.height + mainColumn.height + searchArea.height + row.height + Theme.paddingLarge * 2
            PageHeader {
                id: header
                objectName: "pageHeader"
                title: qsTr("GiphyBeagle")
                extraContent.children: [
                    IconButton {
                        id: aboutButton
                        objectName: "aboutButton"
                        icon.source: "image://theme/icon-m-about"
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                    },
                    IconButton {
                        objectName: "favoritesButton"
                        icon.source: "image://theme/icon-m-favorite"
                        anchors{
                            verticalCenter: parent.verticalCenter
                            left: aboutButton.right
                        }
                        onClicked: pageStack.push(Qt.resolvedUrl("FavoritesPage.qml"))
                    }]

                Column{
                    id: mainColumn
                    anchors{
                        top: header.bottom
                        margins: 5
                    }
                    width: parent.width
                    spacing: Theme.paddingLarge
                    TextArea {
                        id: searchArea
                        objectName: "searchArea"
                        width: parent.width
                        placeholderText: qsTr("Search")
                        label: qsTr("Search")
                        Component.onCompleted: {
                            searchArea.text = getRand();
                        }
                    }
                    Row{
                        id: row
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            top: searchArea.bottom
                            left: parent
                            right: parent
                        }
                        Button {
                            anchors.margins: 5
                            id:fButton
                            text: qsTr("Search")
                            onClicked: network.httpConnect(searchArea.text)
                        }
                        Button {
                            anchors.margins: 5
                            id:randButton
                            text:qsTr("Accidentally")
                            onClicked: {
                                searchArea.text = randUtil.getRandImage();
                                network.httpConnect(searchArea.text)
                            }
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
                AnimatedImage {
                    id: im
                    source: image
                    width: sourceSize.width
                    height: sourceSize.height
                }
            }
            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Add to Favorites")
                    onClicked: {
                        dao.insertImage(id, url, username, title, image);
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
}
