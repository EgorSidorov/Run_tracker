/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.1
import Qt.labs.settings 1.0
import Battery_parametres 1.0

Window {
    id: root
    width: 360
    height: 640
    title: "Бегун"
    property bool newrunopen: true
    visible: true

    Obj_battery_parametres {
        id: qml_obj_battery
    }

    Settings {
        id: settings
        property real weight: 50
        property real timer_start: 5000
        property bool man: true
        property real level1: 6
        property real level2: 9
        property real level3: 12
        property string line_1_color: "red"
        property string line_2_color: "orange"
        property string line_3_color: "yellow"
        property string line_4_color: "green"
        property int width_line: 9
        property string radius: "9"
    }
    Column {
        Item {
            width: root.height / 6.4
            height: root.height / 16
        }

        Menubar {
            id: menubar
            width: root.height / 2.75
            height: root.height
        }
    }

    Newrun {
        id: newrun
        visible: true
    }

    Loader {
        id: loader
        visible: false
    }

    Row {
        Item {
            width: root.height / 64
            height: root.height / 16
        }

        Image {
            height: root.height / 16
            width: root.height / 16
            source: "image/iconhamburger.png"
            MouseArea {
                anchors.fill: parent
                onClicked: menubar.open()
            }
        }
    }
    Component.onCompleted: {
        qml_obj_battery.get_battery_parametres()
    }

    //диалог выхода из приложения
    ExitDialog {
        id: exitdialog
    }
}
