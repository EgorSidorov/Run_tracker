#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>

static const unsigned char qt_resource_tree[] = {
0,
0,0,0,0,2,0,0,0,10,0,0,0,1,0,0,0,
8,0,0,0,0,0,1,0,0,0,0,0,0,0,90,0,
0,0,0,0,1,0,0,0,0,0,0,1,10,0,2,0,
0,0,1,0,0,0,11,0,0,0,218,0,0,0,0,0,
1,0,0,0,0,0,0,0,190,0,0,0,0,0,1,0,
0,0,0,0,0,0,156,0,0,0,0,0,1,0,0,0,
0,0,0,0,240,0,0,0,0,0,1,0,0,0,0,0,
0,0,52,0,0,0,0,0,1,0,0,0,0,0,0,1,
66,0,0,0,0,0,1,0,0,0,0,0,0,0,126,0,
0,0,0,0,1,0,0,0,0,0,0,1,28,0,0,0,
0,0,1,0,0,0,0};
static const unsigned char qt_resource_names[] = {
0,
1,0,0,0,47,0,47,0,19,6,229,121,60,0,76,0,
111,0,119,0,115,0,105,0,103,0,110,0,97,0,108,0,
68,0,105,0,97,0,108,0,111,0,103,0,46,0,113,0,
109,0,108,0,16,10,27,186,156,0,68,0,101,0,108,0,
101,0,116,0,101,0,68,0,105,0,97,0,108,0,111,0,
103,0,46,0,113,0,109,0,108,0,15,7,12,247,220,0,
71,0,114,0,105,0,100,0,95,0,110,0,101,0,119,0,
114,0,117,0,110,0,46,0,113,0,109,0,108,0,12,15,
223,34,60,0,83,0,101,0,116,0,116,0,105,0,110,0,
103,0,115,0,46,0,113,0,109,0,108,0,14,9,23,147,
252,0,72,0,105,0,115,0,116,0,111,0,114,0,121,0,
114,0,117,0,110,0,46,0,113,0,109,0,108,0,11,8,
34,223,92,0,77,0,101,0,110,0,117,0,98,0,97,0,
114,0,46,0,113,0,109,0,108,0,8,8,1,90,92,0,
109,0,97,0,105,0,110,0,46,0,113,0,109,0,108,0,
10,9,203,209,252,0,78,0,101,0,119,0,114,0,117,0,
110,0,46,0,113,0,109,0,108,0,6,7,25,165,165,0,
106,0,115,0,99,0,111,0,100,0,101,0,16,13,203,254,
243,0,102,0,117,0,110,0,99,0,116,0,105,0,111,0,
110,0,112,0,97,0,114,0,97,0,109,0,46,0,106,0,
115,0,14,13,75,26,28,0,69,0,120,0,105,0,116,0,
68,0,105,0,97,0,108,0,111,0,103,0,46,0,113,0,
109,0,108};
static const unsigned char qt_resource_empty_payout[] = { 0, 0, 0, 0, 0 };
QT_BEGIN_NAMESPACE
extern Q_CORE_EXPORT bool qRegisterResourceData(int, const unsigned char *, const unsigned char *, const unsigned char *);
QT_END_NAMESPACE
namespace QmlCacheGeneratedCode {
namespace __ExitDialog_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _jscode_functionparam_js { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace __Newrun_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace __main_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace __Menubar_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace __Historyrun_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace __Settings_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace __Grid_newrun_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace __DeleteDialog_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace __LowsignalDialog_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry);


Registry::Registry() {
        resourcePathToCachedUnit.insert(QStringLiteral("/ExitDialog.qml"), &QmlCacheGeneratedCode::__ExitDialog_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/jscode/functionparam.js"), &QmlCacheGeneratedCode::_jscode_functionparam_js::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Newrun.qml"), &QmlCacheGeneratedCode::__Newrun_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/main.qml"), &QmlCacheGeneratedCode::__main_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Menubar.qml"), &QmlCacheGeneratedCode::__Menubar_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Historyrun.qml"), &QmlCacheGeneratedCode::__Historyrun_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Settings.qml"), &QmlCacheGeneratedCode::__Settings_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Grid_newrun.qml"), &QmlCacheGeneratedCode::__Grid_newrun_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/DeleteDialog.qml"), &QmlCacheGeneratedCode::__DeleteDialog_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/LowsignalDialog.qml"), &QmlCacheGeneratedCode::__LowsignalDialog_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.version = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
QT_PREPEND_NAMESPACE(qRegisterResourceData)(/*version*/0x01, qt_resource_tree, qt_resource_names, qt_resource_empty_payout);
}
const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_qml)() {
    ::unitRegistry();
    Q_INIT_RESOURCE(qml_qmlcache);
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_qml));
int QT_MANGLE_NAMESPACE(qCleanupResources_qml)() {
    Q_CLEANUP_RESOURCE(qml_qmlcache);
    return 1;
}
