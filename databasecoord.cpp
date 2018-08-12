#include "databasecoord.h"
#include <QDebug>
#include <QDate>
DatabaseCoord::DatabaseCoord(QObject *parent) : QObject(parent)
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("databasecoord");
    db.open();
    bool has_track_info=false;
    QSqlQuery query;
    query.exec("SELECT * from sqlite_master");
    while (query.next()) {
        //QString name = query.value(0).toString();//здесь тип "table"
        if(query.value(1).toString()!="track_info")
        list.insert(0,query.value(1).toString());//здесь имя таблицы
        else
            has_track_info=true;

    }
    if(!has_track_info)
        query.exec("CREATE TABLE track_info (name_track varchar(255), time int, distance int, calories int, max_speed double)");
}

DatabaseCoord::~DatabaseCoord()
{
    if(last_query_size != -1){
        for (int i = 0; i < last_query_size; i++)
            delete[] dynamic_massiv[i];
        delete [] dynamic_massiv;
    }
}


void DatabaseCoord::insert_coord(double latitude, double longitude,float speed, bool haspause)
{
    QSqlQuery query(db);
QString str_exec="INSERT INTO "+nowactivetable+"(latitude,longitude,speed,haspause) VALUES(\""+QString::number(latitude,'g',8)+"\",\""+QString::number(longitude,'g',8)+"\",\""+QString::number(speed,'g',8)+"\","+QString::number(haspause)+")";
query.exec(str_exec);
}

void DatabaseCoord::create_table(){
    QSqlQuery query(db);
    int day=QDate::currentDate().dayOfWeek();
    switch (day) {
    case 1:
        nowactivetable="Пнд";
        break;
    case 2:
        nowactivetable="Втр";
        break;
    case 3:
        nowactivetable="Срд";
        break;
    case 4:
        nowactivetable="Чтв";
        break;
    case 5:
        nowactivetable="Птн";
        break;
    case 6:
        nowactivetable="Сбб";
        break;
    case 7:
        nowactivetable="Вск";
        break;
    default:
        break;
    }
    //добавить дату начала бега
    nowactivetable.append(QDate::currentDate().toString("ddMMyyyy"));
    //добавить время начала бега
    nowactivetable.append(QDateTime::currentDateTime().toString("hhmmss"));
    QString zapros="CREATE TABLE "+nowactivetable+"(latitude float,longitude float,speed float,haspause BOOLEAN)";
    query.exec(zapros);
}

void DatabaseCoord::end_run(int time,int distance,int calories, double max_speed){
    QSqlQuery query(db);
    QString str_exec="INSERT INTO track_info(name_track, time, distance, calories, max_speed) VALUES(\""+nowactivetable+"\",\""+QString::number(time)+"\",\""+QString::number(distance)+"\",\""+QString::number(calories)+"\",\""+QString::number(max_speed)+"\")";
    qDebug()<<str_exec;
    query.exec(str_exec);
    list<<nowactivetable;

}

QString DatabaseCoord::get_train_info(QString text,QString name_info){
    QSqlQuery query(db);
    QString str_exec="SELECT "+name_info+ " FROM track_info WHERE name_track=\""+text+"\"";
    query.exec(str_exec);
    query.next();
    return query.value(0).toString();

}

int DatabaseCoord::count_list_track()
{
    return list.length();
}

QString DatabaseCoord::list_history_track(int i){
    return list[i];
}

int DatabaseCoord::count_point(QString text){
    QSqlQuery query(db);
    QString zapros="SELECT count(*) FROM "+text;
    query.exec(zapros);
    query.next();
    int return_value=query.value(0).toInt();
    return return_value;
}

float DatabaseCoord::get_point_latitude(QString text, int i){
    return dynamic_massiv[i][0];
}

void DatabaseCoord::write_all_in_dynamic_massiv(QString text){
    if(last_query_size!=-1){
        for (int i = 0; i < last_query_size; i++)
            delete[] dynamic_massiv[i];
        delete [] dynamic_massiv;
    }
    QSqlQuery query(db);
    QString zapros="SELECT * FROM "+text;
    query.exec(zapros);
    dynamic_massiv=new float *[count_point(text)];
    for (int i = 0; i < count_point(text); i++)
        dynamic_massiv[i] = new float [4];
    while(query.next())
        for(int i=0;i<4;i++)
            dynamic_massiv[query.at()][i]=query.value(i).toFloat();
    last_query_size=count_point(text);
}

float DatabaseCoord::get_point_longitude(QString text, int i){
    return dynamic_massiv[i][1];
}


float DatabaseCoord::get_point_speed(QString text, int i){
    return dynamic_massiv[i][2];
}

bool DatabaseCoord::get_point_haspause(QString text, int i){
    if(dynamic_massiv[i][3]==1)
        return true;
    else
        return false;
}


void DatabaseCoord::delete_table(int index_name){
    QSqlQuery query(db);
    QString zapros="DROP TABLE "+list[index_name];
    query.exec(zapros);
    zapros="DELETE FROM track_info WHERE name_track=\""+list[index_name]+"\"";
    query.exec(zapros);
    list.removeAt(index_name);
}

double DatabaseCoord::getcaloriespersecond(double weight){
    if(weight>=50)
        return (1+(weight-50)/50)*700/3600;
    else
        return 700/3600;
}


