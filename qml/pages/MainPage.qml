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
        answerChanged: {
            jsonModel.source = network.answer
        }
    }

    JSONListModel {
        id: jsonModel
        source: network.answer
    }


    PageHeader {
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
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: page.width
            spacing: Theme.paddingLarge

            Label {
                text: " "
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 32
            }

            TextArea {
                id: searchArea
                placeholderText: "Поиск"
                label: "Поиск"
            }

            Button {
                text: "Найти"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: network.httpConnect(searchArea.text)
            }

            Label {
                text: "Счётчик"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 32
            }

            Label {
                text: counter.count
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 64
            }

            Button {
                text: "Добавить"
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: counter.increment()
            }

            Button {
                text: "Очистить"
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: counter.reset()
            }

            SilicaListView {
                model: jsonModel
                delegate: ListItem {
                    contentHeight: Theme.itemSizeExtraLarge
                    Column{
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        Label {
                            text: url
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
    }
}
