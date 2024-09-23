#ifndef NETWORK_H
#define NETWORK_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class Network : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString answer READ getAnswer NOTIFY answerChanged)

public:
    Q_INVOKABLE Network();
    Q_INVOKABLE void httpConnect(QString searchWord);
    QString getAnswer();

private:
    QNetworkAccessManager *manager;
    QNetworkRequest request;
    QString _answer;

signals:
     void answerChanged();

};

#endif // NETWORK_H
