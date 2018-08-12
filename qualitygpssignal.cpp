
#include "qualitygpssignal.h"
#include <QDebug>

qualitygpssignal::qualitygpssignal(QObject *parent) : QObject(parent)
{
    QGeoSatelliteInfoSource *source = QGeoSatelliteInfoSource::createDefaultSource(this);
    source->setUpdateInterval(1000);
    connect(source,SIGNAL(satellitesInUseUpdated(QList<QGeoSatelliteInfo>)),this,SLOT(satelliteupdate(QList<QGeoSatelliteInfo>)));
    source->startUpdates();
}

void qualitygpssignal::satelliteupdate(QList<QGeoSatelliteInfo> list_satellite){
    int count_bad_satellite=0;
    int count_good_satellite=0;
    int count_great_satellite=0;
    for(int i=0;i<list_satellite.count();i++){
        if(list_satellite.at(i).signalStrength()>20)
            count_bad_satellite++;
        if(list_satellite.at(i).signalStrength()>26)
            count_good_satellite++;
        if(list_satellite.at(i).signalStrength()>32)
            count_great_satellite++;
    }
    if(count_great_satellite>=9){
        sendcountsatelToQml(3);
        return;
    }
    if(count_good_satellite>=7){
        sendcountsatelToQml(2);
        return;
    }
    if(count_bad_satellite>=3){
        sendcountsatelToQml(1);
        return;
    }
    sendcountsatelToQml(0);
    return;
}
