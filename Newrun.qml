import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.1
import Databasecoord 1.0
import Qt.labs.settings 1.0
import "jscode/functionparam.js" as Obj_settings

Item {
    id: root
    width: Window.width
    height: Window.height
    property int time_run: 0
    property real max_speed: 0
    property real calories: 0
    property real stop_image_width
    property real perem_delay_timer: 0
    property string texttimer: "0"
    property bool lock: true
    property var coord
    property bool open_panel: false
    property int quality_signal: 0
    property int current_speed_level: 0 //0-скорость первая.1-до 4 км/ч, 2-до 8 км/ч,3-до 12 км/ч, 4-от 12 км/ч
    property int last_speed_level
    property var last_coordinate
    property var item1circle
    property var item2circle
    property var track_dynamic
    property bool running: false
    property var last_coordinate_latitude
    property var last_coordinate_longitude

    //color
    readonly property string color_pressed: "#c3d1ca"
    readonly property string color_released: "#bdd1ca"

    //исправляет глюк на винде с полным открыванием окна
    onHeightChanged: {
        if (stop_image.source === "qrc:///image/lock3.png")
            stop_image.width = root.height * 0.12 * 0.4
        else {
            stop_image_width = root.height * 0.12 * 0.6
            stop_image.width = stop_image_width
        }
        if (open_panel == true)
            panel.height = root.height / 5
        else
            panel.height = 0
        if (running)
            rectanglenewstart.height = 0
        else
            rectanglenewstart.height = root.height * 0.12 * choose_size()
    }

    visible: true
    //объект для работы с базой данных
    CDatabase {
        id: database
    }
    Connections {
        target: qualitygpssignal // Указываем целевое соединение
        //Реагируем на сигнал из с++
        onSendcountsatelToQml: {
            quality_signal = count
            if (count === 0)
                gps_quality_image.source = "qrc:///image/level0.png"
            else if (count == 1)
                gps_quality_image.source = "qrc:///image/level1.png"
            else if (count == 2)
                gps_quality_image.source = "qrc:///image/level2.png"
            else if (count == 3)
                gps_quality_image.source = "qrc:///image/level3.png"
        }
    }
    function set_last_speed_level(speed) {
        if (speed < settings.level1)
            last_speed_level = 1
        else if (speed < settings.level2)
            last_speed_level = 2
        else if (speed < settings.level3)
            last_speed_level = 3
        else
            last_speed_level = 4
    }

    function pause_run() {
        write_track = false
        src.active = false
        qml_obj_battery.release_battery_ignore()
        run_timer.running = false
        pause_image.source = "image/start_new.png"
        last_speed_level = -1
    }

    function continue_run() {
        write_track = true
        src.active = true
        qml_obj_battery.set_battery_ignore()
        run_timer.running = true
        pause_image.source = "image/Pause-icon.png"
    }

    function on_run_clicked() {
        start_timer_delay_before_start()
        idrectangletimer.visible = true
        if (panel.height !== 0)
            animate_panel_out.start()
        pause_image.source = "image/Pause-icon.png"
        value_distance.text = "0 км"
        value_energy.text = "0 ккал"
        value_temp.text = "0 км/ч"
        value_time.text = "00:00:00"
        idrectangletimer.forceActiveFocus(
                    ) //чтобы работало нажатие кнопки esc или back
    }

    function choose_size() {
        if (Screen.width / Screen.height == 9 / 18)
            return 8 / 9
        else
            return 1
    }
    function start_timer_delay_before_start() {
        texttimer = settings.timer_start / 1000
        perem_delay_timer = settings.timer_start
        timer_delay_before_start.start()
    }
    function end_run() {
        animate_appear_panel.start()
        running = false
        write_track = false
        src.active = false
        qml_obj_battery.release_battery_ignore()
        database.end_run(parseInt(time_run, 10), parseInt(distance),
                         parseInt(value_energy.text), max_speed)
        run_timer.running = false
    }

    Rectangle {
        x: 0
        y: root.height * 0.88
        width: root.width
        height: root.height * 0.12
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
    }
    Timer {
        id: run_timer
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            time_run += 1
            var h = time_run / 3600 ^ 0
            var m = (time_run - h * 3600) / 60 ^ 0
            var s = time_run - h * 3600 - m * 60
            value_time.text = (h < 10 ? "0" + h : h) + ":"
                    + (m < 10 ? "0" + m : m) + ":" + (s < 10 ? "0" + s : s)
            if (src.position.speedValid)
                calories = calories + database.getcaloriespersecond(
                            Obj_settings.get_weight(
                                )) * src.position.speed * 3.6 / 8
            value_energy.text = (calories).toFixed() + " ккал"
        }
    }

    property real distance: 0
    property bool write_track: false

    function starting_run() {
        clear_map()
        running = true
        //item1circle.center=src.position.coordinate;
        database.create_table()
        last_speed_level = 0
        write_track = true
        src.active = true
        qml_obj_battery.set_battery_ignore()
        animate_disappearl_panel.start()
        calories = 0
        distance = 0
        time_run = 0
        animate_panel.start()
        row_inform.visible = true

        run_timer.running = true
        timer_delay_before_start.running = false
        idrectangletimer.visible = false
        perem_delay_timer = 0
        root.forceActiveFocus()
    }

    function adddistance() {
        //радиус Земли
        var R = 6372795
        var distancya = 0
        if (last_speed_level != 0) {
            var lat1 = src.position.coordinate.latitude
            var long1 = src.position.coordinate.longitude

            var lat2 = last_coordinate_latitude
            var long2 = last_coordinate_longitude
            lat1 = lat1 * Math.PI / 180
            lat2 = lat2 * Math.PI / 180
            long1 = long1 * Math.PI / 180
            long2 = long2 * Math.PI / 180
            var cl1 = Math.cos(lat1)
            var cl2 = Math.cos(lat2)
            var sl1 = Math.sin(lat1)
            var sl2 = Math.sin(lat2)
            var delta = long2 - long1
            var cdelta = Math.cos(delta)
            var sdelta = Math.sin(delta)
            var y = Math.sqrt(Math.pow(cl2 * sdelta, 2) + Math.pow(
                                  cl1 * sl2 - sl1 * cl2 * cdelta, 2))
            var x = sl1 * sl2 + cl1 * cl2 * cdelta
            var ad = Math.atan2(y, x)
            distancya = ad * R

            if (distancya === NaN)
                distancya = 0
            distance = distance + distancya
            value_distance.text = (Math.ceil(distance) / 1000).toFixed(
                        2) + " км"
        }
    }
    function clear_map() {
        mapp.clearMapItems()
        item2circle = Qt.createQmlObject('
import QtLocation 5.6
MapCircle{
id:mypositioncirclestop
radius:' + Obj_settings.get_radius() + '
color:\'yellow\'

}
', root)
        //        item1circle=Qt.createQmlObject('
        //import QtLocation 5.6
        //MapCircle{
        //                id:mypositioncirclestart
        //                radius:8
        //                color:\'brown\'

        //            }
        //', root);

        //mapp.addMapItem(item1circle);
        mapp.addMapItem(item2circle)
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
        anchors.fill: root
        height: root.height
        width: root.width
        id: grid_newrun
        Rectangle {
            id: linee
            width: root.width
            color: "#8FBC8F"
            height: root.height / 16
            Image {
                id: gps_quality_image
                x: parent.width - width - parent.height / 20
                y: parent.height * 0.05
                height: parent.height * 0.65
                width: parent.height
                source: "image/level0.png"
            }
            Text {
                x: parent.width - parent.height * 0.8
                y: parent.height * 0.7
                font.pixelSize: parent.height * 0.27
                text: "GPS"
            }
        }
        Rectangle {
            id: panel
            height: 0
            gradient: Gradient {
                GradientStop {
                    position: 0.00
                    color: "#8fbc8f"
                }
                GradientStop {
                    position: 1.00
                    color: "#bdd1ca"
                }
            }
            PropertyAnimation {
                id: animate_panel
                target: panel
                property: "height"
                duration: 500
                from: 0
                to: root.height / 5
                easing.type: Easing.Linear
                onStopped: {
                    open_panel = true
                }
            }
            PropertyAnimation {
                id: animate_panel_out
                target: panel
                property: "height"
                duration: 500
                from: root.height / 5
                to: 0
                easing.type: Easing.Linear
                onStopped: {
                    open_panel = false
                }
            }
            width: root.width
            Row {
                id: row_inform
                Layout.topMargin: root.height / 64
                Layout.bottomMargin: root.height / 64
                visible: false
                width: root.width
                spacing: (root.width - title_time.width - title_distance.width) / 3 - 2

                Rectangle {
                    height: parent.height
                    width: 1
                    gradient: Gradient {
                        GradientStop {
                            position: 0.00
                            color: "#8fbc8f"
                        }
                        GradientStop {
                            position: 1.00
                            color: "#bdd1ca"
                        }
                    }
                }
                Column {
                    anchors.centerIn: parent.Center
                    Text {
                        id: title_distance
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Italic"
                        font.pixelSize: root.height / 32
                        text: "Длительность"
                    }
                    Text {
                        id: value_time
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Italic"
                        font.pixelSize: root.height / 25
                        text: "0"
                    }
                    Item {
                        height: root.height / 48
                        width: 1
                    }

                    Text {
                        id: title_temp
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Italic"
                        font.pixelSize: root.height / 32
                        text: "Скорость"
                    }
                    Text {
                        id: value_temp
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Italic"
                        font.pixelSize: root.height / 25
                        text: "0 км/ч"
                    }
                }
                Column {
                    Text {
                        id: title_time
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Italic"
                        font.pixelSize: root.height / 32
                        text: "Расстояние"
                    }
                    Text {
                        id: value_distance
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Italic"
                        font.pixelSize: root.height / 25
                        text: "0 м"
                    }
                    Item {
                        height: root.height / 48
                        width: 1
                    }
                    Text {
                        id: title_energy
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Italic"
                        font.pixelSize: root.height / 32
                        text: "Калории"
                    }
                    Text {
                        id: value_energy
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Italic"
                        font.pixelSize: root.height / 25
                        text: "0 ккал"
                    }
                }

                Rectangle {
                    height: parent.height
                    width: 1
                    gradient: Gradient {
                        GradientStop {
                            position: 0.00
                            color: "#8fbc8f"
                        }
                        GradientStop {
                            position: 1.00
                            color: "#bdd1ca"
                        }
                    }
                }
            }

            visible: true
        }
        Item {
            width: root.width
            height: root.height - linee.height - panel.height - rectanglestart.height
            Map {
                copyrightsVisible: false

                width: parent.width
                height: parent.height
                id: mapp
                plugin: mapPlugin
                zoomLevel: 18
                center: QtPositioning.coordinate(55.75, 37.62)

                Image {
                    x: parent.width - width
                    height: parent.height * 0.1
                    width: parent.height * 0.1
                    source: "image/now_position.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            mapp.center = src.position.coordinate
                            item2circle.center = coord
                        }
                    }
                }
            }
        }

        //start
        Rectangle {

            id: rectanglenewstart
            x: root.width / 2 - width / 2
            width: root.height * 0.12 * choose_size()
            height: root.height * 0.12 * choose_size()
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
            Image {

                width: parent.width
                height: parent.height
                Image {
                    width: parent.width * 0.6
                    height: parent.height * 0.6
                    x: parent.width / 2 - width / 2.2
                    y: parent.height / 2 - height / 2
                    source: "image/press_start_new.png"
                }
            }
            PropertyAnimation {
                id: animate_disappearl_panel
                target: rectanglenewstart
                property: "height"
                duration: 500
                to: 0
                easing.type: Easing.Linear
                onStopped: rectanglenewstart.height = 0
            }
            PropertyAnimation {
                id: animate_appear_panel
                target: rectanglenewstart
                property: "height"
                duration: 500
                to: root.height * 0.12 * choose_size()
                easing.type: Easing.Linear
                onStopped: rectanglenewstart.height = root.height * 0.12 * choose_size()
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (quality_signal == 0 || quality_signal == 1)
                        lowsignaldialogitem.opening()
                    else {
                        on_run_clicked()
                    }
                }
                onReleased: parent.color = color_released
                onPressed: parent.color = color_pressed
            }
        }

        Row {
            Rectangle {
                id: left_spacer
                height: root.height * 0.12 * choose_size()
                width: (root.width - rectanglestart.width - rectanglestop.width
                        - rectanglepause.width) / 2 * choose_size()
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
                visible: true
            }

            //pause
            Rectangle {
                id: rectanglepause
                height: root.height * 0.12 * choose_size()
                width: height * 2 * choose_size()
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

                Image {
                    width: parent.width
                    height: parent.height
                    Image {
                        id: pause_image
                        x: parent.x + parent.width * 0.5 - width * 0.5
                        y: parent.y + parent.height * 0.5 - height * 0.5
                        width: parent.height * 0.6
                        height: parent.height * 0.6
                        source: "image/Pause-icon.png"
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onReleased: parent.color = color_released
                    onPressed: parent.color = color_pressed
                    onClicked: {
                        if (!lock) {
                            if (write_track)
                                pause_run()
                            else
                                continue_run()
                        }
                    }
                }
            }
            Rectangle {
                Timer {
                    id: ten_second_wait
                    running: false
                    repeat: false
                    interval: 10000
                    onTriggered: {
                        stop_image.width = rectanglestart.width * 0.4
                        stop_image.source = "image/lock3.png"
                        lock = true
                    }
                }

                id: rectanglestart
                x: root.width / 2 - width / 2
                width: root.height * 0.12 * choose_size()
                height: root.height * 0.12 * choose_size()
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

                Image {
                    width: parent.width
                    height: parent.height
                    Image {
                        id: stop_image
                        x: parent.x + parent.width * 0.5 - width * 0.5
                        y: parent.y + parent.height * 0.5 - height * 0.5
                        width: parent.width * 0.6
                        height: parent.height * 0.6
                        source: "image/lock3.png"
                    }
                }
                Text {
                    anchors.centerIn: parent
                    id: textstart
                    color: "#F0F8FF"
                    font.family: "Italic"
                    font.pixelSize: root.height / 30
                    text: ""
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        parent.color = color_pressed
                        if (stop_image.source == "qrc:///image/unlock3.png") {
                            stop_image.width = rectanglestart.width * 0.4
                            stop_image.source = "image/lock3.png"
                            lock = true
                            ten_second_wait.running = false
                        } else {
                            stop_image_width = rectanglestart.width * 0.6
                            stop_image.width = stop_image_width
                            stop_image.source = "image/unlock3.png"
                            lock = false
                            ten_second_wait.running = true
                        }
                    }
                    onReleased: parent.color = color_released
                }
            }
            //stop
            Rectangle {
                id: rectanglestop
                width: root.height * 0.24 * choose_size()
                height: root.height * 0.12 * choose_size()
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
                Image {
                    width: parent.width
                    height: parent.height
                    Image {
                        x: parent.x + parent.width * 0.5 - width * 0.5
                        y: parent.y + parent.height * 0.5 - height * 0.5
                        width: parent.height * 0.6
                        height: parent.height * 0.6
                        source: "image/stop.png"
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onReleased: parent.color = color_released
                    onPressed: parent.color = color_pressed
                    onClicked: {
                        if (!lock) {
                            end_run()
                        }
                    }
                }
            }
        }
    }

    PositionSource {
        id: src
        preferredPositioningMethods: PositionSource.AllPositioningMethods
        updateInterval: 1000

        active: false

        onPositionChanged: {
            coord = src.position.coordinate
            //            if (write_track && src.position.speedValid
            //                    && src.position.latitudeValid
            //                    && src.position.longitudeValid) {
            if (write_track) {

                if ((src.position.speed * 3.6) < settings.level1) {
                    if (last_speed_level == -1 || last_speed_level == 0) {
                        track_dynamic = Qt.createQmlObject(
                                    'import QtLocation 5.6; MapPolyline {}',
                                    root)
                        track_dynamic.line.width = Obj_settings.get_width_line()
                        track_dynamic.line.color = Obj_settings.get_line_1_color()
                        track_dynamic.addCoordinate(coord)
                        mapp.addMapItem(track_dynamic)
                    } else if (last_speed_level != 1) {
                        track_dynamic = Qt.createQmlObject(
                                    'import QtLocation 5.6; MapPolyline {}',
                                    root)
                        track_dynamic.line.width = Obj_settings.get_width_line()
                        track_dynamic.line.color = Obj_settings.get_line_1_color()
                        track_dynamic.addCoordinate(
                                    QtPositioning.coordinate(
                                        last_coordinate_latitude,
                                        last_coordinate_longitude))
                        track_dynamic.addCoordinate(coord)
                        mapp.addMapItem(track_dynamic)
                    } else {
                        track_dynamic.addCoordinate(coord)
                    }
                } else if ((src.position.speed * 3.6) < settings.level2) {
                    if (last_speed_level == -1 || last_speed_level == 0) {
                        track_dynamic = Qt.createQmlObject(
                                    'import QtLocation 5.6; MapPolyline {}',
                                    root)
                        track_dynamic.line.width = Obj_settings.get_width_line()
                        track_dynamic.line.color = Obj_settings.get_line_2_color()
                        track_dynamic.addCoordinate(coord)
                        mapp.addMapItem(track_dynamic)
                    } else if (last_speed_level != 2 || last_speed_level == 0) {
                        track_dynamic = Qt.createQmlObject(
                                    'import QtLocation 5.6; MapPolyline {}',
                                    root)
                        track_dynamic.line.width = Obj_settings.get_width_line()
                        track_dynamic.line.color = Obj_settings.get_line_2_color()
                        track_dynamic.addCoordinate(
                                    QtPositioning.coordinate(
                                        last_coordinate_latitude,
                                        last_coordinate_longitude))
                        track_dynamic.addCoordinate(coord)
                        mapp.addMapItem(track_dynamic)
                    } else {
                        track_dynamic.addCoordinate(coord)
                    }
                } else if ((src.position.speed * 3.6) < settings.level3) {
                    if (last_speed_level == -1 || last_speed_level == 0) {
                        track_dynamic = Qt.createQmlObject(
                                    'import QtLocation 5.6; MapPolyline {}',
                                    root)
                        track_dynamic.line.width = Obj_settings.get_width_line()
                        track_dynamic.line.color = Obj_settings.get_line_3_color()
                        track_dynamic.addCoordinate(coord)
                        mapp.addMapItem(track_dynamic)
                    } else if (last_speed_level != 3 || last_speed_level == 0) {
                        track_dynamic = Qt.createQmlObject(
                                    'import QtLocation 5.6; MapPolyline {}',
                                    root)
                        track_dynamic.line.width = Obj_settings.get_width_line()
                        track_dynamic.line.color = Obj_settings.get_line_3_color()
                        track_dynamic.addCoordinate(
                                    QtPositioning.coordinate(
                                        last_coordinate_latitude,
                                        last_coordinate_longitude))
                        track_dynamic.addCoordinate(coord)
                        mapp.addMapItem(track_dynamic)
                    } else {
                        track_dynamic.addCoordinate(coord)
                    }
                } else {
                    if (last_speed_level == -1 || last_speed_level == 0) {
                        track_dynamic = Qt.createQmlObject(
                                    'import QtLocation 5.6; MapPolyline {}',
                                    root)
                        track_dynamic.line.width = Obj_settings.get_width_line()
                        track_dynamic.line.color = Obj_settings.get_line_4_color()
                        track_dynamic.addCoordinate(coord)
                        mapp.addMapItem(track_dynamic)
                    } else if (last_speed_level != 4) {
                        track_dynamic = Qt.createQmlObject(
                                    'import QtLocation 5.6; MapPolyline {}',
                                    root)
                        track_dynamic.line.width = Obj_settings.get_width_line()
                        track_dynamic.line.color = Obj_settings.get_line_4_color()
                        track_dynamic.addCoordinate(
                                    QtPositioning.coordinate(
                                        last_coordinate_latitude,
                                        last_coordinate_longitude))
                        track_dynamic.addCoordinate(coord)
                        mapp.addMapItem(track_dynamic)
                    } else {
                        track_dynamic.addCoordinate(coord)
                    }
                }
                if (last_speed_level != -1)
                    adddistance()
                last_coordinate = src.position.coordinate
                last_coordinate_latitude = src.position.coordinate.latitude
                last_coordinate_longitude = src.position.coordinate.longitude
                var haspause = false
                if (last_speed_level == -1)
                    haspause = true
                database.insert_coord(src.position.coordinate.latitude,
                                      src.position.coordinate.longitude,
                                      position.speed * 3.6, haspause)
                set_last_speed_level(position.speed * 3.6)

                value_temp.text = (position.speed * 3.6).toFixed(1) + " км/ч"
                if (position.speed * 3.6 > max_speed)
                    max_speed = (position.speed * 3.6).toFixed(1)
                item2circle.center = coord
                mapp.center = coord
            }
        }
    }
    Rectangle {
        id: idrectangletimer
        anchors.fill: parent
        visible: false
        opacity: 0.9
        color: "white"
        Button {
            id: control
            x: parent.width / 2 - width / 2
            width: parent.height * 0.20 * choose_size()
            height: parent.height * 0.20 * choose_size()
            y: parent.height * 0.5 - height / 2
            text: qsTr("")
            onClicked: starting_run()

            contentItem: Text {

                text: texttimer
                font.pixelSize: root.height / 20
                opacity: enabled ? 1.0 : 0.3
                color: "grey"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 100
                opacity: enabled ? 1 : 0.3
                color: control.down ? "#FFDAB9" : "orange"
                radius: size / 2
                readonly property real size: Math.min(control.width,
                                                      control.height)
                width: size
                height: size
                anchors.centerIn: parent

                Canvas {
                    id: canvas
                    anchors.fill: parent

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.strokeStyle = "#800080"
                        ctx.lineWidth = parent.size / 20
                        ctx.beginPath()
                        var startAngle = Math.PI / 6 * 3
                        var endAngle = startAngle - (1 - perem_delay_timer
                                                     / settings.timer_start) * Math.PI * 2
                        ctx.arc(width / 2, height / 2,
                                width / 2 - ctx.lineWidth / 2 - 2,
                                startAngle, endAngle)
                        ctx.stroke()
                    }
                }
            }
        }

        Timer {
            id: timer_delay_before_start
            interval: 50
            repeat: true
            onTriggered: {
                perem_delay_timer -= 50
                canvas.requestPaint()
                if (perem_delay_timer % 1000 == 0)
                    texttimer = perem_delay_timer / 1000
                if (perem_delay_timer <= 0)
                    starting_run()
            }
        }
        Keys.onEscapePressed: {
            timer_delay_before_start.running = false
            idrectangletimer.visible = false
            root.forceActiveFocus()
        }
        Keys.onBackPressed: {
            timer_delay_before_start.running = false
            idrectangletimer.visible = false
            root.forceActiveFocus()
        }
    }
    Keys.onEscapePressed: {
        exitdialog.opening()
    }
    Keys.onBackPressed: {
        exitdialog.opening()
    }

    Component.onCompleted: {
        root.forceActiveFocus()
        mapp.center = src.position.coordinate
        item2circle = Qt.createQmlObject('
import QtLocation 5.6
MapCircle{
id:mypositioncirclestop
radius:' + Obj_settings.get_radius() + '
color:\'yellow\'

}
', root)
        mapp.addMapItem(item2circle)
        item2circle.center = src.position.coordinate
    }
    Component.onDestruction: {
        if (write_track) {
            database.end_run(parseInt(time_run, 10), parseInt(distance),
                             parseInt(value_energy.text), max_speed)
        }
    }

    //диалог низкого сигнала
    LowsignalDialog {
        id: lowsignaldialogitem
    }
    ExitDialog {
        id: exitdialog
    }
}
