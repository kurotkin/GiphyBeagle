import QtQuick 2.0
import Sailfish.Silica 1.0
import custom.Counter 1.0
import custom.Network 1.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    Dao{id: dao}

    Counter {
        id: counter
        count: 15
    }

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
       anchors.fill: parent
       header:PageHeader {
           objectName: "pageHeader"
           title: qsTr("GiphyBeagle")
           extraContent.children: [
               IconButton {
                   objectName: "aboutButton"
                   icon.source: "image://theme/icon-m-about"
                   anchors.verticalCenter: parent.verticalCenter
                   onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
               }

           ]
           Column {
               id: column
               width: page.width
               spacing: Theme.paddingLarge

               Label {
                   text: " "
                   anchors.horizontalCenter: parent.horizontalCenter
                   font.pixelSize: 64
               }

               TextArea {
                   id: searchArea
                   placeholderText: "Поиск"
                   label: "Поиск"
                   text: "cat"
               }

               Button {
                   id:fButton
                   text: "Найти"
                   anchors.horizontalCenter: parent.horizontalCenter
                   onClicked: network.httpConnect(searchArea.text)
               }


           }
       }
       model: ListModel { id: dataModel }
       delegate: ListItem {
            contentHeight: Theme.itemSizeExtraLarge
            Column{
                height: 250
                Image {
                    source: image
                    width: sourceSize.width
                    height: sourceSize.height
                }
                Label {
                   text: username
                }
                Label {
                   text: title
                }
             }
        }
    }

}
