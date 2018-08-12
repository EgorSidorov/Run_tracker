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

Column {
    property alias mapp: mapp
    property alias stop_image: stop_image
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
