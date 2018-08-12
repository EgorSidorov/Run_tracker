#ifndef QUALITYGPSSIGNAL_H
#define QUALITYGPSSIGNAL_H

#include <QObject>
#include <QGeoSatelliteInfoSource>
#include <QGeoSatelliteInfo>
#include <QList>
class qualitygpssignal : public QObject
{
    Q_OBJECT
public:
    explicit qualitygpssignal(QObject *parent = nullptr);

signals:
    // Сигнал для передачи данных в qml-интерфейс
    void sendcountsatelToQml(int count);
public slots:
    void satelliteupdate(QList<QGeoSatelliteInfo> list_satellite);
};

#endif // QUALITYGPSSIGNAL_H
