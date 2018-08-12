import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.1
import Qt.labs.settings 1.0
Drawer{
    width: root.height/2.75
    height: root.height
    id:menubar
    
    
    Rectangle{
        anchors.fill: parent
        color:"#8FBC8F"
    }
    
    ColumnLayout{
        spacing: root.height/42.667
        anchors.fill: parent
        anchors.leftMargin: root.height/32
        anchors.topMargin: root.height/21.333
        
        Row{
            Image{
                width:root.height/18.286
                height:root.height/16
                source:"image/running_man.png"
                fillMode: Image.Stretch
            }
            Item{
                width:root.height/106.667
                height:root.height/16
            }
            
            Button{
                id:newtraning
                text:"Новая тренировка"
                font.pixelSize:root.height/60
                width:root.height/4.923
                height:root.height/16
                background: Rectangle {
                    color: "#F0F8FF"
                    radius: root.height/64
                    
                }
                onClicked: {newrunopen=true;newrun.visible=true;loader.visible=false;menubar.close();}
            }
        }
        Row{
            Image{
                width:root.height/16
                height:root.height/16
                source:"image/history.png"
                fillMode: Image.Stretch
            }
            Item{
                width:root.height/320
                height:root.height/16
            }
            Button{
                font.pixelSize:root.height/60
                text:"История тренировок"
                width:root.height/4.923
                height:root.height/16
                background: Rectangle {
                    color: "#F0F8FF"
                    radius: root.height/64
                    
                }
                onClicked: {newrunopen=false;loader.setSource("Historyrun.qml");newrun.visible=false;loader.visible=true;menubar.close();}
            }
        }
        Row{
            Image{
                width: root.height/17.2;height:root.height/17.2
                source:"image/settings_icon.png"
                fillMode: Image.Stretch
            }
            Item{
                width:root.height/140
                height:root.height/16
            }
            Button{
                font.pixelSize:root.height/60
                text:"Настройки"
                width:root.height/4.923
                height:root.height/16
                background: Rectangle {
                    color: "#F0F8FF"
                    radius: root.height/64
                    
                }
                onClicked: {newrunopen=false;loader.setSource("Settings.qml");newrun.visible=false;loader.visible=true;menubar.close();}
            }
        }
        Row{
            Image{
                width: root.height/18.286;height:root.height/16
                source:"image/exit2.png"
                fillMode: Image.Stretch
            }
            Item{
                width:root.height/106.667
                height:root.height/16
            }
            Button{
                font.pixelSize:root.height/60
                text:"Выйти из программы"
                width:root.height/4.923
                height:root.height/16
                background: Rectangle {
                    color: "#F0F8FF"
                    radius: root.height/64
                    
                }
                onClicked: {exitdialog.opening();}
            }
        }
        Item {
            // spacer item
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
    onClosed: newrunopen==false? loader.forceActiveFocus():newrun.forceActiveFocus();
    
}
