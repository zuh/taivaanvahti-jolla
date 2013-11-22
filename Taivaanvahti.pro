# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-taivaanvahti

CONFIG += sailfishapp

SOURCES += src/Taivaanvahti.cpp

OTHER_FILES += \
    rpm/harbour-taivaanvahti.spec \
    rpm/harbour-taivaanvahti.yaml \
    qml/cover/CoverPage.qml \
    qml/pages/Tietoja.qml \
    qml/pages/Photos.qml \
    qml/pages/Havainto.qml \
    qml/pages/Havainnot.qml \
    qml/pages/Haku.qml \
    qml/harbour-taivaanvahti.qml \
    harbour-taivaanvahti.desktop \
    harbour-taivaanvahti.png
