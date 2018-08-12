#include "battery_parametres.h"
#include <QDebug>

battery_parametres::battery_parametres(QObject *parent) : QObject(parent)
{
}

QString battery_parametres::get_battery_parametres()
{
    QString return_string = " ";
#if defined(Q_OS_ANDROID)
    QString test = "qdwo";
    QAndroidJniObject javaNotification = QAndroidJniObject::fromString(test);
    QAndroidJniObject::callStaticMethod<void>("org/producer/egor/run_tracker/NotificationClient",
                                       "notify",
                                       "(Ljava/lang/String;)V",
                                       javaNotification.object<jstring>());
    main_activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    QAndroidJniObject j_string =  main_activity.callObjectMethod("get_battery_stat","()Ljava/lang/String;");





    QString qt_string = j_string.toString();
    qDebug()<<qt_string;
#endif
    return return_string;
}

void battery_parametres::set_battery_ignore()
{
    //main_activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    main_activity.callObjectMethod("lock_battery","()Ljava/lang/String;");
}

void battery_parametres::release_battery_ignore()
{
    //main_activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    main_activity.callObjectMethod("unlock_battery","()Ljava/lang/String;");
}
