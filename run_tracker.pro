TEMPLATE = app

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

QT += location sql positioning
android{
QT += androidextras
}

SOURCES += \
    databasecoord.cpp \
    main.cpp \
    qualitygpssignal.cpp \
    battery_parametres.cpp

RESOURCES += qml.qrc

#target.path = C:\QtGitProject\run_tracker
#target.path = $$[QT_INSTALL_EXAMPLES]/androidextras/notification
#INSTALLS += target

DISTFILES += \
    main.qml \
    ExitDialog.qml \
    Newrun.qml \
    Historyrun.qml \
    image/delete_button.png \
    Rowstartstop.qml \
    Rectangletimer.qml \
    LowsignalDialog.qml \
    settings_logic.js \
    DeleteDialog.qml \
    Settings.qml \
    Settings_object.qml \
    android/src/org/producer/egor/run_tracker/NotificationClient.java \
    android/AndroidManifest.xml

HEADERS += \
    databasecoord.h \
    qualitygpssignal.h \
    battery_parametres.h
