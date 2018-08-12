#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <databasecoord.h>
#include <QQmlContext>
#include <qualitygpssignal.h>
#include "battery_parametres.h"
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    qualitygpssignal quality;
    engine.rootContext()->setContextProperty("qualitygpssignal", &quality);
    qmlRegisterType<battery_parametres>("Battery_parametres",1,0,"Obj_battery_parametres");
    qmlRegisterType<DatabaseCoord>("Databasecoord",1,0,"CDatabase");
    engine.addImportPath(QStringLiteral(":/imports"));
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));
    return app.exec();
}

