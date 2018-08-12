#ifndef DATABASECOORD_H
#define DATABASECOORD_H

#include <QObject>
#include <QSql>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QStringListModel>
class DatabaseCoord : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseCoord(QObject *parent = nullptr);
    ~DatabaseCoord();
    QSqlDatabase db;
    QString nowactivetable;
    QStringList list;
    Q_INVOKABLE void insert_coord(double latitude, double longitude, float speed, bool haspause);
    Q_INVOKABLE void create_table();
    Q_INVOKABLE int count_list_track();
    Q_INVOKABLE QString list_history_track(int i);
    Q_INVOKABLE void end_run(int time, int distance, int calories, double max_speed);
    Q_INVOKABLE int count_point(QString text);
    Q_INVOKABLE float get_point_latitude(QString text, int i);
    Q_INVOKABLE float get_point_longitude(QString text, int i);
    Q_INVOKABLE void delete_table(int index_name);
    Q_INVOKABLE QString get_train_info(QString text, QString name_info);
    Q_INVOKABLE double getcaloriespersecond(double weight);
    Q_INVOKABLE float get_point_speed(QString text, int i);
    Q_INVOKABLE bool get_point_haspause(QString text, int i);
    Q_INVOKABLE void write_all_in_dynamic_massiv(QString text);
private:
    float **dynamic_massiv;
    float last_query_size=-1;
};

#endif // DATABASECOORD_H
