#include "network.h"
#include <QJsonDocument>
#include <QJsonValue>
#include <QJsonArray>
#include <QJsonObject>

Network::Network() : QObject()
{

}

QString Network::getAnswer() {
    return this->_answer;
}

void Network::httpConnect(){

    QString _url = "https://api.giphy.com/v1/gifs/search?api_key=UUf3cd49L8HLBEb9njVcXLuzUtbWTSnF&limit=1&q=cat";

    qDebug() << QSslSocket::supportsSsl() << QSslSocket::sslLibraryBuildVersionString() << QSslSocket::sslLibraryVersionString();


    manager = new QNetworkAccessManager();

    QObject::connect(manager, &QNetworkAccessManager::finished,
                     this,
                     [=](QNetworkReply *reply) {
                         if (reply->error()) {
                             qDebug() << reply->errorString();
                             return;
                         }

                         QString answer = reply->readAll();
                         _answer = answer;
                         emit answerChanged();

                         QByteArray json_bytes = answer.toLocal8Bit();
                         auto jsonDocument = QJsonDocument::fromJson(json_bytes);
                         auto json_obj=jsonDocument.object();

                         QVariantList timeArray = json_obj.toVariantMap()["hourly"].toJsonObject().toVariantMap()["time"].toList();
                         QVariantList temperatureArray = json_obj.toVariantMap()["hourly"].toJsonObject().toVariantMap()["temperature_180m"].toList();
                         QVariantList precipitationProbabilityArray = json_obj.toVariantMap()["hourly"].toJsonObject().toVariantMap()["precipitation_probability"].toList();


                     });

    request.setUrl(QUrl("https://api.open-meteo.com/v1/forecast?latitude=55.7522&longitude=37.6156&hourly=temperature_180m,precipitation_probability,precipitation"));
    manager->get(request);
}
