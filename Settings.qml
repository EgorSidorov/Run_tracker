import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.2
import "jscode/functionparam.js" as Obj_settings

Rectangle {

    property int type_line: 0
    id: settings_qml
    signal menubar_open
    width: Window.width
    height: Window.height
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
    Column {
        anchors.fill: parent
        Rectangle {
            id: linee
            width: settings_qml.width
            color: "#8FBC8F"
            height: settings_qml.height / 16
        }
        TabBar {
            id: bar
            width: parent.width
            TabButton {
                text: qsTr("Пользователь")
            }
            TabButton {
                text: qsTr("Уведомления")
            }
            TabButton {
                text: qsTr("Отображение")
            }
        }
        StackLayout {
            id: tablayout

            currentIndex: bar.currentIndex
            //anchors.fill: parent
            Item {
                Column {
                    id: maingrid
                    // anchors.fill: parent
                    width: settings_qml.width
                    height: settings_qml.height
                    spacing: settings_qml.height / 64
                    Rectangle {
                        width: settings_qml.width
                        color: "#8FBC8F"
                        height: settings_qml.height / 16
                    }
                    Item {
                        width: 1
                        height: bar.height
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Text {
                            font.pixelSize: settings_qml.height / 32
                            text: "Вес,кг:"
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        TextField {
                            height: settings_qml.height / 20
                            width: settings_qml.height / 4
                            id: value_weight
                            font.pixelSize: settings_qml.height / 32
                            text: Obj_settings.get_weight()
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Text {
                            font.pixelSize: settings_qml.height / 32
                            text: "Пол:"
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        ComboBox {
                            height: value_weight.height
                            width: settings_qml.height / 4
                            id: value_sex
                            currentIndex: settings.man === true ? 1 : 0
                            font.pixelSize: settings_qml.height / 32
                            model: ["Женский", "Мужской"]
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Text {
                            font.pixelSize: settings_qml.height / 32
                            text: "Время старта, с:"
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        TextField {
                            id: value_timer_start
                            height: value_weight.height
                            width: settings_qml.height / 4
                            font.pixelSize: settings_qml.height / 32
                            text: settings.timer_start / 1000
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Text {
                            font.pixelSize: settings_qml.height / 32
                            text: "Уровень 1, км/ч:"
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        TextField {
                            id: value_level1
                            height: value_weight.height
                            width: settings_qml.height / 4
                            font.pixelSize: settings_qml.height / 32
                            text: settings.level1
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Text {
                            font.pixelSize: settings_qml.height / 32
                            text: "Уровень 2, км/ч:"
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        TextField {
                            id: value_level2
                            height: value_weight.height
                            width: settings_qml.height / 4
                            font.pixelSize: settings_qml.height / 32
                            text: settings.level2
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Text {
                            font.pixelSize: settings_qml.height / 32
                            text: "Уровень 3, км/ч:"
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        TextField {
                            id: value_level3
                            height: value_weight.height
                            width: settings_qml.height / 4
                            font.pixelSize: settings_qml.height / 32
                            text: settings.level3
                        }
                    }
                    Item {
                        height: 1
                        width: settings_qml.height / 32
                    }

                    Row {
                        Item {
                            height: 1
                            width: (settings_qml.width - button_accepted.width) / 2
                        }
                        Rectangle {
                            id: button_accepted
                            width: settings_qml.height / 4
                            height: settings_qml.height / 16
                            color: "#a45ba2"
                            radius: settings_qml.height / 64
                            Text {
                                x: parent.width / 5.9
                                y: parent.height / 17.4
                                font.pixelSize: settings_qml.height / 24
                                text: "Принять"
                                color: "white"
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    settings.timer_start = value_timer_start.text * 1000
                                    Obj_settings.set_weight(value_weight.text)
                                    if (value_sex.currentIndex == 0)
                                        settings.man = false
                                    else
                                        settings.man = true
                                    settings.level1 = value_level1.text
                                    settings.level2 = value_level2.text
                                    settings.level3 = value_level3.text
                                    rectangleaccept.visible = true
                                    menubar_open()
                                    timeraccept.start()
                                }
                            }
                        }
                    }
                }
            }
            Item {
            }

            Item {
                id: second_page
                Column {
                    id: second_page_grid
                    //anchors.fill: settings_qml
                    width: settings_qml.width
                    height: settings_qml.height
                    spacing: settings_qml.height / 64
                    Rectangle {
                        id: second_page_linee
                        width: settings_qml.width
                        color: "#8FBC8F"
                        height: settings_qml.height / 16
                    }
                    Item {
                        width: 1
                        height: bar.height
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Text {
                            font.pixelSize: settings_qml.height / 32
                            text: "Цвет 1 скорости:"
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Button {
                            font.pixelSize: settings_qml.height / 32
                            text: "Установить цвет"
                            onClicked: {
                                type_line = 1
                                colorDialog.setColor(
                                            Obj_settings.get_line_1_color())
                                colorDialog.open()
                            }
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Text {
                            font.pixelSize: settings_qml.height / 32
                            text: "Цвет 2 скорости:"
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Button {
                            font.pixelSize: settings_qml.height / 32
                            text: "Установить цвет"
                            onClicked: {
                                type_line = 2
                                colorDialog.setColor(
                                            Obj_settings.get_line_2_color())
                                colorDialog.open()
                            }
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Text {
                            font.pixelSize: settings_qml.height / 32
                            text: "Цвет 3 скорости:"
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Button {
                            font.pixelSize: settings_qml.height / 32
                            text: "Установить цвет"
                            onClicked: {
                                type_line = 3
                                colorDialog.setColor(
                                            Obj_settings.get_line_3_color())
                                colorDialog.open()
                            }
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Text {
                            font.pixelSize: settings_qml.height / 32
                            text: "Цвет 4 скорости:"
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Button {
                            font.pixelSize: settings_qml.height / 32
                            text: "Установить цвет"
                            onClicked: {
                                type_line = 4
                                colorDialog.setColor(
                                            Obj_settings.get_line_4_color())
                                colorDialog.open()
                            }
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Text {
                            font.pixelSize: settings_qml.height / 32
                            text: "Ширина линии"
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        TextField {
                            id: value_width_line
                            height: value_weight.height
                            width: settings_qml.height / 4
                            font.pixelSize: settings_qml.height / 32
                            text: settings.width_line
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        Text {
                            font.pixelSize: settings_qml.height / 32
                            text: "Радиус начала м конца"
                        }
                    }
                    Row {
                        Item {
                            height: 1
                            width: settings_qml.height / 64
                        }
                        TextField {
                            id: value_radius
                            height: value_weight.height
                            width: settings_qml.height / 4
                            font.pixelSize: settings_qml.height / 32
                            text: settings.radius
                        }
                    }
                    //                    Row {
                    //                        Item {
                    //                            height: 1
                    //                            width: settings_qml.height / 64
                    //                        }
                    //                        Text {
                    //                            font.pixelSize: settings_qml.height / 32
                    //                            text: "Вес,кг:"
                    //                        }
                    //                    }
                    //                    Row {
                    //                        Item {
                    //                            height: 1
                    //                            width: settings_qml.height / 64
                    //                        }
                    //                        TextField {
                    //                            width: settings_qml.height / 4
                    //                            id: value_height
                    //                            text: Obj_settings.get_weight()
                    //                        }
                    //                    }
                    Row {
                        Item {
                            height: 1
                            width: (settings_qml.width - button_accepted_2.width) / 2
                        }
                        Rectangle {
                            id: button_accepted_2
                            width: settings_qml.height / 4
                            height: settings_qml.height / 16
                            color: "#a45ba2"
                            radius: settings_qml.height / 64
                            Text {
                                x: parent.width / 5.9
                                y: parent.height / 17.4
                                font.pixelSize: settings_qml.height / 24
                                text: "Принять"
                                color: "white"
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    settings.width_line = value_width_line.text
                                    settings.radius = value_radius.text
                                    rectangleaccept.visible = true
                                    menubar_open()
                                    timeraccept.start()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Keys.onEscapePressed: {
        exitdialog.opening()
    }
    Keys.onBackPressed: {
        exitdialog.opening()
    }
    Timer {
        id: timeraccept
        interval: 1500
        repeat: false
        onTriggered: rectangleaccept.visible = false
    }
    Rectangle {
        id: rectangleaccept
        color: "grey"
        opacity: 0.75
        x: parent.width / 2 - width / 2
        y: parent.height * 0.9 - height / 2
        width: parent.width * 0.8
        height: parent.height * 0.1
        visible: false
        Text {
            id: textaccept
            width: parent.width
            height: parent.height
            color: "white"
            font.pixelSize: settings_qml.height / 25
            text: qsTr("Настройки приняты")
            font.family: "Forte"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Component.onCompleted: settings_qml.forceActiveFocus()
    ColorDialog {
        id: colorDialog
        title: "Выберите цвет"
        onAccepted: {
            if (type_line === 1)
                Obj_settings.set_line_1_color(colorDialog.color)
            if (type_line === 2)
                Obj_settings.set_line_2_color(colorDialog.color)
            if (type_line === 3)
                Obj_settings.set_line_3_color(colorDialog.color)
            if (type_line === 4)
                Obj_settings.set_line_4_color(colorDialog.color)
            colorDialog.visible = false
        }
        onRejected: {
            colorDialog.visible = false
        }
        Component.onCompleted: visible = false
    }
    ExitDialog {
        id: exitdialog
    }
}
