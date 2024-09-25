import QtQuick 2.0
import QtQuick.LocalStorage 2.0

QtObject {
    id: root
    property var db

    function selectImages(callback) {
        db.readTransaction(function (tx) {
            var result = tx.executeSql("SELECT * FROM images;");
            callback(result.rows);
        });
    }

    function searchImages(txt, callback) {
        db.readTransaction(function (tx) {
            var result = tx.executeSql("SELECT * FROM images WHERE title LIKE ?;", [txt]);
            callback(result.rows);
        });
    }

    function insertImage(id, url, username, title, image_url) {
        db.transaction(function (tx) {
            tx.executeSql("INSERT INTO images (id, url, username, title, image_url) VALUES(?, ?, ?, ?, ?);", [id, url, username, title, image_url]);
        });
    }

    function deleteImage(id) {
        db.transaction(function (tx) {
            tx.executeSql("DELETE FROM images WHERE id = ?;", [id]);
        });
    }

    Component.onCompleted: {
        db = LocalStorage.openDatabaseSync("images", "1.0");
        db.transaction(function (tx) {
                tx.executeSql("CREATE TABLE IF NOT EXISTS images (id TEXT PRIMARY KEY, url TEXT, username TEXT, title TEXT, image_url TEXT);");
            }
        );
    }
}
