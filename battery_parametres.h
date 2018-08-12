#ifndef BATTERY_PARAMETRES_H
#define BATTERY_PARAMETRES_H

#include <QObject>
#if defined(Q_OS_ANDROID)
#include <QtAndroidExtras/QAndroidJniObject>
#endif
class battery_parametres : public QObject
{
    Q_OBJECT
public:
    explicit battery_parametres(QObject *parent = nullptr);
    Q_INVOKABLE void set_battery_ignore();

    Q_INVOKABLE QString get_battery_parametres();
    Q_INVOKABLE void release_battery_ignore();
signals:

public slots:

private:
    QAndroidJniObject main_activity;
};

#endif // BATTERY_PARAMETRES_H
