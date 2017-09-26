import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import SERComp 1.0


ApplicationWindow {
    visible: true
    width: 1200
    height: 720
    title: qsTr("SER")
    property alias canvas: main_page.canvas
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 2
       Page{

               Page1 {
                   id:main_page

               }
       }

        Page {
            List{

                id:emolist

            }

            id:second_page

        }
        Page{
            WaveView{
                id:wave_view
            }
            Timer {
                id: refreshTimer
                interval: 1 /20 * 1000 // 60 Hz
                running: false
                repeat: true
                onTriggered: {
                    ser_engine.update(wave_view.chartView.series(0));
                   // console.log('triggered');
                }
            }

        }

    }

    SER_Engine{
         id:ser_engine
         Component.onCompleted: {
             busy.running=true;
             main_page.page1form.stsp_button.enabled=false;
             ser_engine.set_workdir("D:/SER_Client_Desktop");
             ser_engine.preboot_engine();
             busy.running=false;
            main_page.page1form.stsp_button.enabled=true;
            console.log(wave_view.width);


         }
         Component.onDestruction: {
             ser_engine.stop_engine();
         }
         onOut_predict_result: {
               main_page.page1form.emo_predict.text=predict;
               emolist.emoModel.append({emotion:predict,voice_seg:voice_seg});
              console.log("predict="+predict+";voice_seg="+voice_seg+";probability="+probability);
              draw_prob(probability);

          }
          function draw_prob(probability1)
          {
              var probability=new Array(5);
              probability[0]=probability1[2];
              probability[1]=probability1[1];
              probability[2]=probability1[3];
              probability[3]=probability1[0];
              probability[4]=probability1[4];

             var ctx= canvas.getContext('2d');
              ctx.clearRect(0,0,canvas.width,canvas.height);
              ctx.drawImage(canvas.base_img,0,0);
              ctx.lineCap="round";
              ctx.lineWidth=2;
              ctx.strokeStyle=Qt.rgba(0.3,0.7,1.0,0);
              var x_s=new Array(5);
              var y_s=new Array(5);
              var x_e=new Array(5);
              var y_e=new Array(5);

              var radius=canvas.radius;

             // ctx.beginPath();

              for(var i=0;i<5;i++)
              {

                  x_s[i]=(canvas.x_out[i]-canvas.centroid[0])*probability[i]+canvas.centroid[0];
                  y_s[i]=(canvas.y_out[i]-canvas.centroid[1])*probability[i]+canvas.centroid[1];
                  x_e[i]=(canvas.x_out[(i+1)%5]-canvas.centroid[0])*probability[i]+canvas.centroid[0];
                  y_e[i]=(canvas.y_out[(i+1)%5]-canvas.centroid[1])*probability[i]+canvas.centroid[1];

                  var x_temp=(x_s[i]+x_e[i])/2;
                  var y_temp=(y_s[i]+y_e[i])/2;
                  console.log("i="+String(i));
                  console.log("x_delta="+String(canvas.centroid[0]-x_temp));
                  console.log("y_delta="+String(canvas.centroid[1]-y_temp));

                  var gradient=ctx.createLinearGradient((x_s[i]+x_e[i])/2,(y_s[i]+y_e[i])/2,canvas.centroid[0],canvas.centroid[1]);
                  gradient.addColorStop(0,"#FFCCCC");
                  gradient.addColorStop(1,"#CCFFFF");

                  ctx.fillStyle=gradient;
                  ctx.beginPath();
                  ctx.moveTo(canvas.centroid[0],canvas.centroid[1]);

                   ctx.lineTo(x_s[i],y_s[i]);
                  ctx.lineTo(x_e[i],y_e[i]);
                  ctx.lineTo(canvas.centroid[0],canvas.centroid[1]);
                   ctx.closePath();
                  ctx.fill();

                   // console.assert()
                  //console.log("x"+i+"="+x[i]+";y"+i+"="+y[i]);
              }

              /*

              ctx.moveTo(x[0],y[0]);
              for(var i=1;i<=5;i++)
              {
                  ctx.lineTo(x[i%5],y[i%5]);
              }
              */

              ctx.closePath();

              ctx.stroke();

              canvas.requestPaint();

          }
    }


    BusyIndicator{
        id:busy;
        running: false;
        anchors.centerIn: parent;
        z:2;
    }


}
