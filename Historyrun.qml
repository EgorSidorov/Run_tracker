import QtQuick 2.0
import QtQuick.Controls 2.1
import Databasecoord 1.0
import QtQuick.Window 2.2
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Layouts 1.1
import "jscode/functionparam.js" as Obj_settings

Item {
    property int current_index: 0
    property var item1circle
    property var item2circle
    property int delete_index
    property int last_speed_level: 0 //0-скорость первая.1-до 4 км/ч, 2-до 8 км/ч,3-до 12 км/ч, 4-от 12 км/ч
    property var track_dynamic
    property var last_coordinate
    CDatabase {
        id: database
    }
    function add_coord(haspause, latitude, longitude, level, color) {
        if (haspause === true || last_speed_level == 0) {
            track_dynamic = Qt.createQmlObject(
                        'import QtLocation 5.6; MapPolyline {}', root)
            track_dynamic.line.width = Obj_settings.get_width_line()
            track_dynamic.line.color = color
            track_dynamic.addCoordinate(QtPositioning.coordinate(latitude,
                                                                 longitude))
            mapp.addMapItem(track_dynamic)
        } else if (last_speed_level !== level) {
            track_dynamic = Qt.createQmlObject(
                        'import QtLocation 5.6; MapPolyline {}', root)
            track_dynamic.line.width = Obj_settings.get_width_line()
            track_dynamic.line.color = color
            track_dynamic.addCoordinate(last_coordinate)
            track_dynamic.addCoordinate(QtPositioning.coordinate(latitude,
                                                                 longitude))
            mapp.addMapItem(track_dynamic)
        } else {
            track_dynamic.addCoordinate(QtPositioning.coordinate(latitude,
                                                                 longitude))
        }
    }

    function delete_track() {
        database.delete_table(delete_index)
        modelforlist.remove(delete_index)
    }

    Drawer {
        width: root.height / 2.75
        height: root.height
        id: menubar

        Rectangle {
            anchors.fill: parent
            color: "#8FBC8F"
        }

        Rectangle {
            id: no_train
            x: root.height / 64
            y: root.height / 64
            width: root.height * 5 / 64
            height: root.height * 5 / 64
            visible: false
            color: "#8FBC8F"
            RowLayout {
                anchors.fill: parent
                Text {
                    Layout.alignment: Qt.AlignCenter
                    text: "Вы пока не\nпровели тренировок"
                    font.family: "Blackadder ITC"
                    font.pixelSize: root.height / 30
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
        ListModel {
            id: modelforlist
        }

        ListView {
            id: historylistview
            y: 0
            x: (parent.width - root.height * 20 / 64) / 2
            width: root.height * 15 / 64
            height: menubar.height
            model: modelforlist
            spacing: root.height / 80
            topMargin: root.height / 50
            bottomMargin: root.height / 50
            delegate: Row {
                Rectangle {
                    id: day_rectangle
                    width: root.height * 5 / 64
                    height: root.height * 5 / 64
                    //radius: root.height*5/64
                    color: "#008B8B"
                    RowLayout {
                        anchors.fill: parent

                        Text {
                            Layout.alignment: Qt.AlignCenter
                            color: "white"

                            text: day
                            font.family: "Blackadder ITC"
                            font.pixelSize: root.height / 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
                Rectangle {
                    id: button
                    state: full_name
                    color: "#008B8B"
                    height: root.height * 5 / 64
                    width: root.height * 10 / 64
                    Column {
                        spacing: root.height / 150
                        Item {
                            width: 1
                            height: root.height / 140
                        }
                        Row {
                            Item {
                                height: 1
                                width: root.height / 120
                            }

                            Text {
                                color: "white"
                                id: buttontext
                                text: "Дата: " + name
                                font.pixelSize: root.height / 60
                            }
                        }
                        Row {
                            Item {
                                height: 1
                                width: root.height / 120
                            }
                            Text {
                                color: "white"
                                text: "Время: " + train_time
                                font.pixelSize: root.height / 60
                            }
                        }
                    }

                    Menu {
                        id: rect
                        x: button.x + button.width
                        MenuItem {
                            text: "Удалить"
                            onClicked: {
                                database.delete_table(
                                            historylistview.currentIndex)
                                modelforlist.remove(
                                            historylistview.currentIndex)
                            }
                        }
                        visible: false
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            menubar.close()
                            clear_map()
                            progressbar.visible = true
                            current_index = index
                            last_speed_level = 0
                            var count_point = database.count_point(button.state)
                            if (count_point !== 0) {
                                database.write_all_in_dynamic_massiv(
                                            button.state)
                                for (var i = 0; i < count_point; i++) {
                                    var current_speed = database.get_point_speed(
                                                button.state, i)
                                    var latitude = database.get_point_latitude(
                                                button.state, i)
                                    var longitude = database.get_point_longitude(
                                                button.state, i)
                                    if (current_speed < Obj_settings.get_level1(
                                                )) {
                                        add_coord(database.get_point_haspause(
                                                      button.state, i),
                                                  latitude, longitude, 1,
                                                  Obj_settings.get_line_1_color(
                                                      ))
                                        last_speed_level = 1
                                    } else if (current_speed < Obj_settings.get_level2(
                                                   )) {
                                        add_coord(database.get_point_haspause(
                                                      button.state, i),
                                                  latitude, longitude, 2,
                                                  Obj_settings.get_line_2_color(
                                                      ))
                                        last_speed_level = 2
                                    } else if (current_speed < Obj_settings.get_level3(
                                                   )) {
                                        add_coord(database.get_point_haspause(
                                                      button.state, i),
                                                  latitude, longitude, 3,
                                                  Obj_settings.get_line_3_color(
                                                      ))
                                        last_speed_level = 3
                                    } else {
                                        add_coord(database.get_point_haspause(
                                                      button.state, i),
                                                  latitude, longitude, 4,
                                                  Obj_settings.get_line_4_color(
                                                      ))
                                        last_speed_level = 4
                                    }
                                    last_coordinate = QtPositioning.coordinate(
                                                latitude, longitude)
                                    progressbar.value = i / count_point
                                }
                                item1circle.center = QtPositioning.coordinate(
                                            database.get_point_latitude(
                                                button.state, 0),
                                            database.get_point_longitude(
                                                button.state, 0))
                                item2circle.center = QtPositioning.coordinate(
                                            database.get_point_latitude(
                                                button.state,
                                                database.count_point(
                                                    button.state) - 1),
                                            database.get_point_longitude(
                                                button.state,
                                                database.count_point(
                                                    button.state) - 1))
                                mapp.center = QtPositioning.coordinate(
                                            database.get_point_latitude(
                                                button.state, 0),
                                            database.get_point_longitude(
                                                button.state, 0))
                            }
                            model_track_info.clear()
                            var time_start = database.list_history_track(
                                        current_index).slice(11, 13) + ":"
                                    + database.list_history_track(current_index).slice(
                                        13, 15) + ":" + database.list_history_track(
                                        current_index).slice(15, 17)
                            var time_run = database.get_train_info(
                                        button.state, "time")
                            var h = time_run / 3600 ^ 0
                            var m = (time_run - h * 3600) / 60 ^ 0
                            var s = time_run - h * 3600 - m * 60
                            model_track_info.append({
                                                        "name": "Время начала: ",
                                                        "value": time_start
                                                    })
                            model_track_info.append({
                                                        "name": "Расстояние: ",
                                                        "value": (database.get_train_info(
                                                                      button.state,
                                                                      "distance") / 1000).toFixed(
                                                                     2) + " км"
                                                    })
                            model_track_info.append({
                                                        "name": "Длительность: ",
                                                        "value": (h < 10 ? "0" + h : h) + ":" + (m < 10 ? "0" + m : m) + ":" + (s < 10 ? "0" + s : s)
                                                    })
                            model_track_info.append({
                                                        "name": "Средняя скорость: ",
                                                        "value": (database.get_train_info(
                                                                      button.state,
                                                                      "distance") * 3.6
                                                                  / database.get_train_info(
                                                                      button.state,
                                                                      "time")).toFixed(
                                                                     1) + " км/ч"
                                                    })
                            model_track_info.append({
                                                        "name": "Максимальная скорость: ",
                                                        "value": (database.get_train_info(
                                                                      button.state,
                                                                      "max_speed") + " км/ч")
                                                    })
                            model_track_info.append({
                                                        "name": "Сожжено калорий: ",
                                                        "value": database.get_train_info(
                                                                     button.state,
                                                                     "calories") + " ккал"
                                                    })
                            progressbar.visible = false
                        }
                        onPressAndHold: {
                            historylistview.currentIndex = index
                            rect.visible = true
                        }
                    }
                }
                Rectangle {
                    width: root.height * 5 / 64
                    height: root.height * 5 / 64
                    color: "#008B8B"

                    Image {
                        id: deletebutton
                        anchors.fill: parent
                        fillMode: Image.Stretch
                        source: "image/delete_button3.png"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                delete_index = index
                                deletedialog.opening()
                            }
                        }
                    }
                }
            }
        }

        onClosed: root.forceActiveFocus()
    }
    function clear_map() {
        mapp.clearMapItems()
        item2circle = Qt.createQmlObject('
import QtLocation 5.6
MapCircle{
id:mypositioncirclestop
radius:'+Obj_settings.get_radius()+'
color:\'yellow\'

}
', root)
        item1circle = Qt.createQmlObject('
import QtLocation 5.6
MapCircle{
id:mypositioncirclestart
radius:'+Obj_settings.get_radius()+'
color:\'brown\'

}
', root)

        mapp.addMapItem(item1circle)
        mapp.addMapItem(item2circle)
    }
    id: root
    width: Window.width
    height: Window.height
    Rectangle {
        width: root.width
        color: "#F0F8FF"
        height: root.height
    }

    Plugin {
        id: mapPlugin
        name: "osm" // "mapboxgl", "esri", ...
        // PluginParameter {
        //     name:
        //     value:
        // }
    }

    Column {
        id: maingrid
        anchors.fill: root
        width: root.width
        height: root.height
        Rectangle {
            id: linee
            width: root.width
            color: "#8FBC8F"
            height: root.height / 16
        }
        Map {
            copyrightsVisible: false

            width: root.width
            height: root.height - linee.height - list_track_info.height
            id: mapp
            center: QtPositioning.coordinate(55.75, 37.62)
            plugin: mapPlugin
            zoomLevel: 18
            Item {
                x: 0
                y: 0
                Column {
                    spacing: root.height / 48
                    Row {
                        Rectangle {
                            color: Obj_settings.get_line_1_color()
                            width: root.height / 16
                            height: root.height / 48
                        }

                        Text {
                            text: "<" + Obj_settings.get_level1() + " км/ч"
                        }
                    }
                    Row {
                        Rectangle {
                            color: Obj_settings.get_line_2_color()
                            width: root.height / 16
                            height: root.height / 48
                        }
                        Text {
                            text: "<" + Obj_settings.get_level2() + " км/ч"
                        }
                    }
                    Row {
                        Rectangle {
                            color: Obj_settings.get_line_3_color()
                            width: root.height / 16
                            height: root.height / 48
                        }
                        Text {
                            text: "<" + Obj_settings.get_level3() + " км/ч"
                        }
                    }
                    Row {
                        Rectangle {
                            color: Obj_settings.get_line_4_color()
                            width: root.height / 16
                            height: root.height / 48
                        }
                        Text {
                            text: ">" + Obj_settings.get_level3() + " км/ч"
                        }
                    }
                }
            }
        }
        Rectangle {
            height: root.height / 4
            width: root.width
            gradient: Gradient {
                GradientStop {
                    position: 0.00
                    color: "#bdd1ca"
                }
                GradientStop {
                    position: 1.00
                    color: "#8fbc8f"
                }
            }
            ListView {
                topMargin: root.height / 128
                bottomMargin: root.height / 128
                leftMargin: root.height / 64
                rightMargin: root.height / 64
                id: list_track_info
                model: model_track_info
                height: parent.height
                width: parent.width

                delegate: Row {

                    Text {
                        color: "#5d3d6b"
                        text: name
                        font.pixelSize: root.height / 32
                    }
                    Text {
                        color: "#5d3d6b"
                        text: value
                        font.pixelSize: root.height / 32
                    }
                }
            }
        }
    }
    ListModel {
        id: model_track_info
    }
    Image {
        height: root.height / 16
        width: root.height / 16
        y: 0
        x: root.width - root.height / 16
        source: "image/History_list.png"
        MouseArea {
            anchors.fill: parent
            onClicked: menubar.open()
        }
    }

    //конструктор
    Component.onCompleted: {
        for (var i = 0; i < database.count_list_track(); i++) {
            modelforlist.append({
                                    "name": (database.list_history_track(
                                                 i).slice(3, 5) + "."
                                             + database.list_history_track(i).slice(
                                                 5, 7) + "." + database.list_history_track(
                                                 i).slice(7, 11)),
                                    "day": database.list_history_track(
                                               i).slice(0, 2),
                                    "train_time": (database.list_history_track(
                                                       i).slice(11, 13) + ":"
                                                   + database.list_history_track(i).slice(
                                                       13, 15) + ":" + database.list_history_track(
                                                       i).slice(15, 17)),
                                    "full_name": database.list_history_track(i)
                                })
        }
        root.forceActiveFocus()
        if (database.count_list_track() === 0) {
            no_train.visible = true
        }

        menubar.open()
    }
    Keys.onEscapePressed: {
        exitdialog.opening()
    }
    Keys.onBackPressed: {
        exitdialog.opening()
    }
    ExitDialog {
        id: exitdialog
    }
    DeleteDialog {
        id: deletedialog
    }
    ProgressBar {
        id: progressbar
        indeterminate: true
        x: root.width / 2 - width / 2
        y: root.height / 2 - height / 2
        width: root.height / 4
        height: root.height / 10
        visible: false
        padding: 2

        background: Rectangle {
            width: root.height / 4
            height: root.height / 10
            color: "#e6e6e6"
            radius: 3
        }

        contentItem: Item {
            width: root.height / 4
            height: root.height / 10

            Rectangle {
                width: progressbar.value * parent.width
                height: parent.height
                radius: 2
                color: "#17a81a"
            }
        }
    }
}
