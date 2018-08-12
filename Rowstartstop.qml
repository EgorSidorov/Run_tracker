import QtQuick 2.0

Item {
    id:root
    Row{
        Rectangle{
            height: rectanglestart.height
            width:(root.width-rectanglestart.width*3)/2
            color:"#8FBC8F"
            visible: false
        }
        Rectangle{
            id:left_spacer
            height: rectanglestart.height
            width:rectanglestart.width
            color:"#8FBC8F"
            visible: false
        }


    Rectangle{
        width: root.height*0.24
        height: root.height*0.12
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#bdd1ca";
            }
            GradientStop {
                position: 1.00;
                color: "#bdd1ca";
            }
        }

        Image {
            width:parent.width
            height: parent.height
            //fillMode: Image.Stretch
            //source: "image/Cast_Glass_1.png"
            Image {
                x:parent.x+parent.width*0.5-width*0.5
                y:parent.y+parent.height*0.5-height*0.5
                width: parent.height*0.6
                height: parent.height*0.6
                source: "image/Pause-icon.png"
            }
        }
        //border.color: "black"
        //border.width: 3
        //radius: root.height/640*8
        visible: true
    }

    Rectangle{
        id:rectanglestart
        //x:root.height*0.925
        x:root.width/2-width/2
        width: root.height*0.12
        height: root.height*0.12
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#bdd1ca";
            }
            GradientStop {
                position: 1.00;
                color: "#bdd1ca";
            }
        }

        Image {
            width:parent.width
            height: parent.height
            id: nopush
            //fillMode: Image.Stretch
            //source: "image/Cast_Glass_1.png"
            Image {
                id:triangle
                x:parent.x+parent.width*0.5-width*0.5
                y:parent.y+parent.height*0.5-height*0.5
                width: parent.width*0.6
                height: parent.height*0.6
                source: "image/start_new.png"
            }
        }
        //border.color: "black"
        //border.width: 3
        //radius: root.height/640*8
        Text {
        anchors.centerIn: parent
             id:textstart
             color: "#F0F8FF"
             font.family: "Italic"
             font.pixelSize:root.height/30
             text: ""
        }
        MouseArea{
            anchors.fill: parent
            onReleased: {triangle.source="image/start_new.png"
                if(triangle.source=="qrc:///image/start_new.png")
                {
                    triangle.visible=false;
                    textstart.text="3";
                    if(panel.height!==0)
                    animate_panel_out.start();
                    panel.height=0;
                    value_distance.text=0;
                    value_energy.text=0;
                    value_temp.text=0;
                    value_time.text=0;
                    button_3_figure_timer.start();
                }
//                else if(textstart.text=="Завершить")
//                {
//                    textstart.text="Начать бег";
//                    run_timer.stop();
//                    write_track=false;
//                    database.end_run(parseInt(value_time.text,10),parseFloat(value_distance.text));
//                } else {
//                    button_3_figure_timer.stop();
//                    three_figure_timer=3;
//                    textstart.text="Начать бег";
//                }
            }
            onPressed: triangle.source="image/press_start_new.png"
        }
    }
    //stop
        Rectangle{
            width: root.height*0.24
            height: root.height*0.12
//            gradient: Gradient {
//                GradientStop {
//                    position: 0.00;
//                    color: "#bdd1ca";
//                }
//                GradientStop {
//                    position: 1.00;
//                    color: "#bdd1ca";
//                }
//            }

            Image {
                width:parent.width
                height: parent.height
                //fillMode: Image.Stretch
                //source: "image/Cast_Glass_1.png"
                Image {
                    x:parent.x+parent.width*0.5-width*0.5
                    y:parent.y+parent.height*0.5-height*0.5
                    width: parent.height*0.6
                    height: parent.height*0.6
                    source: "image/stop.png"
                }
            }
            //border.color: "black"
            //border.width: 3
            //radius: root.height/640*8
            visible: true
        }



    Rectangle{
        height: rectanglestart.height
        width:(root.width-rectanglestart.width*3)/2
        color:"#8FBC8F"
        visible: false
    }
    }
}
