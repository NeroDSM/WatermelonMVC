#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "wmmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Setting up model
    WMModel model;

    QQmlApplicationEngine engine;

    // Adding model class to QML context
    QQmlContext *ctxt = engine.rootContext();
    ctxt->setContextProperty("WMModel", &model);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
