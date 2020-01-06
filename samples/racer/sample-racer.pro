#--------------------------------------------------------------------
# path to build directory (generated by cmake)
#--------------------------------------------------------------------
PRE_TARGETDEPS += $$PWD/../../setup.pri
include($$PWD/../../setup.pri)

#--------------------------------------------------------------------
# project
#--------------------------------------------------------------------
QT -= core gui
TARGET = sample-racer
TEMPLATE = app
CONFIG += c++11
CONFIG -= qt

DESTDIR = $$GPLAY_OUTPUT_DIR/bin
QMAKE_CLEAN += $$DESTDIR/$$TARGET

CONFIG(debug, debug|release):
    DEFINES += _DEBUG
DEFINES += GP_USE_GAMEPAD

INCLUDEPATH += $$GPLAY_OUTPUT_DIR/include/gplayengine/
INCLUDEPATH += $$GPLAY_OUTPUT_DIR/include/gplayengine/thirdparty

#--------------------------------------------------------------------
# platform specific
#--------------------------------------------------------------------
linux: {
    DEFINES += __linux__
    PRE_TARGETDEPS += $$GPLAY_OUTPUT_DIR/lib/libgplay-deps.a
    PRE_TARGETDEPS += $$GPLAY_OUTPUT_DIR/lib/libgplay.a
    LIBS += -L$$GPLAY_OUTPUT_DIR/lib/ -lgplay
    LIBS += -L$$GPLAY_OUTPUT_DIR/lib/thirdparty/ -lgplay-deps
    LIBS += -lm -lGL -lrt -ldl -lX11 -lpthread -lsndio
    QMAKE_POST_LINK += $$quote(rsync -rau $$PWD/game.dds.config $${DESTDIR}/$${TARGET}.config$$escape_expand(\n\t))
}

#--------------------------------------------------------------------
# files
#--------------------------------------------------------------------
SOURCES += src/RacerGame.cpp
HEADERS += src/RacerGame.h