#include "network.h"
#include <QJsonDocument>
#include <QJsonValue>
#include <QJsonArray>
#include <QJsonObject>

Network::Network() : QObject()
{ }

QString Network::getAnswer() {
    return this->_answer;
}

void Network::httpConnect(QString searchWord){
    QString _url = "https://api.giphy.com/v1/gifs/search?api_key=UUf3cd49L8HLBEb9njVcXLuzUtbWTSnF&limit=10&q=" + searchWord;
    manager = new QNetworkAccessManager();
    QObject::connect(manager, &QNetworkAccessManager::finished,
                     this,
                     [=](QNetworkReply *reply) {
                         if (reply->error()) {
                             qDebug() << reply->errorString();
                             return;
                         }

                         QString answer = reply->readAll();
                         QByteArray json_bytes = answer.toLocal8Bit();
                         QJsonDocument jsonDocument = QJsonDocument::fromJson(json_bytes);
                         QJsonObject json_obj=jsonDocument.object();

                         QJsonArray jsonArray;
                         foreach(QJsonValue v, json_obj["data"].toArray()){
                             QJsonObject jsonItemObj = v.toObject();
                             QJsonObject newJsonItemObj;
                             QString id = jsonItemObj["id"].toString();
                             QString url = jsonItemObj["url"].toString();
                             QString username = jsonItemObj["username"].toString();
                             QString title = jsonItemObj["title"].toString();
                             QString images = jsonItemObj["images"].toObject()["downsized"].toObject()["url"].toString();
                             newJsonItemObj["id"] = id;
                             newJsonItemObj["url"] = url;
                             newJsonItemObj["username"] = username;
                             newJsonItemObj["title"] = title;
                             newJsonItemObj["image"] = images;
                             jsonArray.append(newJsonItemObj);
                         }
                         auto a = QJsonDocument(jsonArray);
                         QString strFromObj = QJsonDocument(a).toJson(QJsonDocument::Compact).toStdString().c_str();
                         _answer = strFromObj;
                         emit answerChanged();
                     });

    request.setUrl(QUrl(_url));
    manager->get(request);
}
