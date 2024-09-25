import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property var img
    property var title

    CopyUtil{ id: copyUtil }

    DialogHeader {
        id: header
        acceptText: qrTs("Copy Url")
        cancelText: qrTs("Back")
    }

    AnimatedImage {
        id: im
        source: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        width: sourceSize.width
        height: sourceSize.height
    }

    onAccepted: {
       copyUtil.copyText(img)
    }

    Component.onCompleted: {
        header.title = title;
    }
}
