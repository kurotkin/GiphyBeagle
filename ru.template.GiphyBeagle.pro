TARGET = ru.template.GiphyBeagle

QT += network

CONFIG += \
    auroraapp

PKGCONFIG += \

SOURCES += \
    src/counter.cpp \
    src/main.cpp \
    src/network.cpp

HEADERS += \
    src/counter.h \
    src/network.h

DISTFILES += \
    rpm/ru.template.GiphyBeagle.spec \

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += auroraapp_i18n

TRANSLATIONS += \
    translations/ru.template.GiphyBeagle.ts \
    translations/ru.template.GiphyBeagle-ru.ts \
