TARGET = com.kurotkin.GiphyBeagle

QT += network

CONFIG += \
    auroraapp

PKGCONFIG += \

SOURCES += \
    src/main.cpp \
    src/network.cpp

HEADERS += \
    src/network.h

DISTFILES += \
    qml/pages/CopyUtil.qml \
    qml/pages/Dao.qml \
    qml/pages/FavoritesPage.qml \
    qml/pages/ImageDialog.qml \
    qml/pages/RandUtil.qml \
    rpm/com.kurotkin.GiphyBeagle.spec \

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += auroraapp_i18n

TRANSLATIONS += \
    translations/com.kurotkin.GiphyBeagle.ts \
    translations/com.kurotkin.GiphyBeagle-ru.ts \
