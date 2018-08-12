import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
Rectangle{
    anchors.fill:parent
    visible: false
        opacity: 0.9
        color:"white"
    Button {
         id: control
         x:parent.width/2-width/2
         width: parent.height*0.20*choose_size()
         height: parent.height*0.20*choose_size()
         y:parent.height*0.5-height/2
         text: qsTr("")
         onClicked: {
             timer_delay_before_start.running=false;
         idrectangletimer.visible=false;
         write_track=true;
             animate_panel.start();
             row_inform.visible=true;
             animate_disappearl_panel.start();
         }

         contentItem: Text {

             text: texttimer
             font.pixelSize: root.height/20
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
             color: control.down ? "red" : "orange"
             radius: size / 2
             readonly property real size: Math.min(control.width, control.height)
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
                     var endAngle = startAngle - (1-perem_delay_timer/delay_start) * Math.PI*2
                     ctx.arc(width / 2, height / 2, width / 2 - ctx.lineWidth / 2 - 2, startAngle, endAngle)
                     ctx.stroke()
                 }
             }
         }
     }

            Timer{
                id:timer_delay_before_start
                interval: 50
                repeat:true
                onTriggered: {
                    perem_delay_timer-=50;
                    canvas.requestPaint();
                    if(perem_delay_timer%1000 == 0)
                        texttimer=perem_delay_timer/1000;
                    if(perem_delay_timer==0){
                        running=false;
                    parent.visible=false;
                    write_track=true;
                        animate_panel.start();
                        row_inform.visible=true;
                        animate_disappearl_panel.start();

                    }
                }

            }
}

