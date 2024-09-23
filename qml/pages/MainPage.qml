import QtQuick 2.0
import Sailfish.Silica 1.0
import custom.Counter 1.0
import custom.Network 1.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    Counter {
        id: counter
        count: 15
    }

    Network {
        id: network
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
            Button {
                text: "Download"
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: network.httpConnect("dog")
            }

            Label {
                text: network.answer
                textFormat: Text.RichText
                wrapMode: Text.WordWrap
                anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
                font.pixelSize: 32
            }
        }
    }
}
