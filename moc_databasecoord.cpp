/****************************************************************************
** Meta object code from reading C++ file 'databasecoord.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "databasecoord.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'databasecoord.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_DatabaseCoord_t {
    QByteArrayData data[29];
    char stringdata0[350];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_DatabaseCoord_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_DatabaseCoord_t qt_meta_stringdata_DatabaseCoord = {
    {
QT_MOC_LITERAL(0, 0, 13), // "DatabaseCoord"
QT_MOC_LITERAL(1, 14, 12), // "insert_coord"
QT_MOC_LITERAL(2, 27, 0), // ""
QT_MOC_LITERAL(3, 28, 8), // "latitude"
QT_MOC_LITERAL(4, 37, 9), // "longitude"
QT_MOC_LITERAL(5, 47, 5), // "speed"
QT_MOC_LITERAL(6, 53, 8), // "haspause"
QT_MOC_LITERAL(7, 62, 12), // "create_table"
QT_MOC_LITERAL(8, 75, 16), // "count_list_track"
QT_MOC_LITERAL(9, 92, 18), // "list_history_track"
QT_MOC_LITERAL(10, 111, 1), // "i"
QT_MOC_LITERAL(11, 113, 7), // "end_run"
QT_MOC_LITERAL(12, 121, 4), // "time"
QT_MOC_LITERAL(13, 126, 8), // "distance"
QT_MOC_LITERAL(14, 135, 8), // "calories"
QT_MOC_LITERAL(15, 144, 9), // "max_speed"
QT_MOC_LITERAL(16, 154, 11), // "count_point"
QT_MOC_LITERAL(17, 166, 4), // "text"
QT_MOC_LITERAL(18, 171, 18), // "get_point_latitude"
QT_MOC_LITERAL(19, 190, 19), // "get_point_longitude"
QT_MOC_LITERAL(20, 210, 12), // "delete_table"
QT_MOC_LITERAL(21, 223, 10), // "index_name"
QT_MOC_LITERAL(22, 234, 14), // "get_train_info"
QT_MOC_LITERAL(23, 249, 9), // "name_info"
QT_MOC_LITERAL(24, 259, 20), // "getcaloriespersecond"
QT_MOC_LITERAL(25, 280, 6), // "weight"
QT_MOC_LITERAL(26, 287, 15), // "get_point_speed"
QT_MOC_LITERAL(27, 303, 18), // "get_point_haspause"
QT_MOC_LITERAL(28, 322, 27) // "write_all_in_dynamic_massiv"

    },
    "DatabaseCoord\0insert_coord\0\0latitude\0"
    "longitude\0speed\0haspause\0create_table\0"
    "count_list_track\0list_history_track\0"
    "i\0end_run\0time\0distance\0calories\0"
    "max_speed\0count_point\0text\0"
    "get_point_latitude\0get_point_longitude\0"
    "delete_table\0index_name\0get_train_info\0"
    "name_info\0getcaloriespersecond\0weight\0"
    "get_point_speed\0get_point_haspause\0"
    "write_all_in_dynamic_massiv"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_DatabaseCoord[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      14,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    4,   84,    2, 0x02 /* Public */,
       7,    0,   93,    2, 0x02 /* Public */,
       8,    0,   94,    2, 0x02 /* Public */,
       9,    1,   95,    2, 0x02 /* Public */,
      11,    4,   98,    2, 0x02 /* Public */,
      16,    1,  107,    2, 0x02 /* Public */,
      18,    2,  110,    2, 0x02 /* Public */,
      19,    2,  115,    2, 0x02 /* Public */,
      20,    1,  120,    2, 0x02 /* Public */,
      22,    2,  123,    2, 0x02 /* Public */,
      24,    1,  128,    2, 0x02 /* Public */,
      26,    2,  131,    2, 0x02 /* Public */,
      27,    2,  136,    2, 0x02 /* Public */,
      28,    1,  141,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::Void, QMetaType::Double, QMetaType::Double, QMetaType::Float, QMetaType::Bool,    3,    4,    5,    6,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   10,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Double,   12,   13,   14,   15,
    QMetaType::Int, QMetaType::QString,   17,
    QMetaType::Float, QMetaType::QString, QMetaType::Int,   17,   10,
    QMetaType::Float, QMetaType::QString, QMetaType::Int,   17,   10,
    QMetaType::Void, QMetaType::Int,   21,
    QMetaType::QString, QMetaType::QString, QMetaType::QString,   17,   23,
    QMetaType::Double, QMetaType::Double,   25,
    QMetaType::Float, QMetaType::QString, QMetaType::Int,   17,   10,
    QMetaType::Bool, QMetaType::QString, QMetaType::Int,   17,   10,
    QMetaType::Void, QMetaType::QString,   17,

       0        // eod
};

void DatabaseCoord::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        DatabaseCoord *_t = static_cast<DatabaseCoord *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->insert_coord((*reinterpret_cast< double(*)>(_a[1])),(*reinterpret_cast< double(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3])),(*reinterpret_cast< bool(*)>(_a[4]))); break;
        case 1: _t->create_table(); break;
        case 2: { int _r = _t->count_list_track();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 3: { QString _r = _t->list_history_track((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 4: _t->end_run((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< double(*)>(_a[4]))); break;
        case 5: { int _r = _t->count_point((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 6: { float _r = _t->get_point_latitude((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 7: { float _r = _t->get_point_longitude((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 8: _t->delete_table((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 9: { QString _r = _t->get_train_info((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 10: { double _r = _t->getcaloriespersecond((*reinterpret_cast< double(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 11: { float _r = _t->get_point_speed((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 12: { bool _r = _t->get_point_haspause((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 13: _t->write_all_in_dynamic_massiv((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject DatabaseCoord::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_DatabaseCoord.data,
      qt_meta_data_DatabaseCoord,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *DatabaseCoord::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *DatabaseCoord::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_DatabaseCoord.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int DatabaseCoord::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 14)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 14;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 14)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 14;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
