package org.producer.egor.run_tracker;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.provider.Settings;
import android.app.Activity;
import org.qtproject.qt5.android.QtNative;
import android.os.PowerManager;

public class NotificationClient extends org.qtproject.qt5.android.bindings.QtActivity
{
    private static NotificationManager m_notificationManager;
    private static Notification.Builder m_builder;
    private static NotificationClient m_instance;
    private PowerManager pm;
    private PowerManager.WakeLock wl;

    public NotificationClient()
    {
        m_instance = this;
    }

    public static void notify(String s)
    {
        if (m_notificationManager == null) {
            m_notificationManager = (NotificationManager)m_instance.getSystemService(Context.NOTIFICATION_SERVICE);
            m_builder = new Notification.Builder(m_instance);
            m_builder.setSmallIcon(R.drawable.icon);
            m_builder.setContentTitle("A message Egor!");
        }

        m_builder.setContentText(s);
        m_notificationManager.notify(1, m_builder.build());
    }

    public String get_battery_stat()
    {
        String str = "123";
        return str;
    }

    public String lock_battery()
    {
         pm = (PowerManager) getSystemService(Context.POWER_SERVICE);
         wl = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "My Tag");
         wl.acquire();
         String str = "123";
         return str;
    }

    public String unlock_battery()
    {
         wl.release();
         String str = "123";
         return str;
    }

}
