#include <auroraapp.h>
#include <QtQuick>
#include "network.h"

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> application(Aurora::Application::application(argc, argv));
    application->setOrganizationName(QStringLiteral("com.kurotkin"));
    application->setApplicationName(QStringLiteral("GiphyBeagle"));

    qmlRegisterType<Network>("custom.Network", 1, 0, "Network");


    QScopedPointer<QQuickView> view(Aurora::Application::createView());
    view->setSource(Aurora::Application::pathTo(QStringLiteral("qml/GiphyBeagle.qml")));
    view->show();

    return application->exec();
}
