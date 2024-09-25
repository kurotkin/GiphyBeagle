import QtQuick 2.0

Item {
    function getRandImage(){
        var arr = ["cat", "dog", "monkey", "elephant", "squirrel", "mouse", "pig", "bear", "horse", "donkey", "chicken"];
        var i = parseInt(arr.length * Math.random(), 10);
        return arr[i];
    }
}
