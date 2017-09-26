
import QtQuick 2.7

Item{
    property alias page1form: page1form
    property alias canvas: page1form.canvas

    Page1Form {
        id: page1form
        /*
        button1.onClicked: {
            if(button1.text=="Start")
            {
                button1.text="Stop";
            }
            else
            {
                button1.text="Start";
            }

            console.log("Button Pressed. Entered text: " + textField1.text);
        }
        */

          stsp_button.onReleased: {
            if(stsp_button.text=="Start")
            {
               // ser_engine.set_workdir("D:/xiaomin/SER_Client_Desktop");
               // ser_engine.start_engine();
                //emolist.emoModel.clear();
                stsp_button.enabled=false;
                ser_engine.start_recorder();
                var ctx=canvas.getContext('2d');
                ctx.clearRect(0,0,canvas.width,canvas.height);
                ctx.drawImage(canvas.base_img,0,0);
                stsp_button.text="Stop";
                emo_predict.text="Listening";
                stsp_button.enabled=true;
                refreshTimer.running=true;
            }
            else
            {
               // ser_engine.stop_engine();
                stsp_button.enabled=false;
                ser_engine.stop_recorder();
                stsp_button.text="Start";
                emo_predict.text="Emotion";
                stsp_button.enabled=true;
                refreshTimer.running=false;


            }
        }

        canvas.onPaint: {
            /*
            var ctx = canvas.getContext('2d')
            ctx.lineCap="round"
            ctx.lineWidth = 5.0
            //ctx.strokeStyle = canvas.color
            ctx.beginPath()
            ctx.moveTo(canvas.lastX, canvas.lastY)
            canvas.lastX = canvasMsAr.mouseX
            canvas.lastY = canvasMsAr.mouseY
            ctx.lineTo(canvas.lastX, canvas.lastY)
            ctx.stroke()
            */
        }
        canvasMsAr.onPressed: {
            /*
            canvas.lastX = canvasMsAr.mouseX
            canvas.lastY = canvasMsAr.mouseY
            */
        }
        canvasMsAr.onPositionChanged: {

           // canvas.requestPaint()
        }

        function draw_pentagonal()
        {

            //绘制五边形
            var width=canvas.width;
            var padding=100;
            var height=canvas.height-padding;
            var temp=Math.tan(72/180*Math.PI)
            var edgelen=height/temp*2;


            canvas.emo[0]="N";
            canvas.emo[1]="E";
            canvas.emo[2]="P";
            canvas.emo[3]="A";
            canvas.emo[4]="S";

            canvas.x_out[0]=width/2;
            canvas.y_out[0]=padding/2;
            canvas.x_out[2]=canvas.x_out[0]+edgelen/2;
            canvas.x_out[3]=canvas.x_out[0]-edgelen/2;
            canvas.y_out[2]=height+padding/2;
            canvas.y_out[3]=canvas.y_out[2];
            canvas.x_out[4]=canvas.x_out[0]-edgelen*Math.cos(36/180*Math.PI);
            canvas.x_out[1]=canvas.x_out[0]+edgelen*Math.cos(36/180*Math.PI);
            canvas.y_out[4]=padding/2+edgelen*Math.sin(36/180*Math.PI);
            canvas.y_out[1]=canvas.y_out[4];


            canvas.radius=edgelen/(2*Math.sin(36/180*Math.PI));
            canvas.centroid[0]=canvas.x_out[0];
            canvas.centroid[1]=canvas.y_out[0]+ canvas.radius;



            for(var i=0;i<5;i++)
            {
                canvas.x_in[i]=(canvas.x_out[i]+ canvas.centroid[0])/2;
                canvas.y_in[i]=(canvas.y_out[i]+ canvas.centroid[1])/2;
            }


            var ctx=canvas.getContext('2d');
            ctx.lineCap="round";
            ctx.lineWidth=2;
            ctx.strokeStyle=Qt.rgba(0.3,0.7,1.0,0.8);
            ctx.beginPath();

            ctx.moveTo(canvas.x_out[0],canvas.y_out[0]);

            for( i=1;i<=5;i++)
            {
                ctx.lineTo(canvas.x_out[i%5],canvas.y_out[i%5]);
            }
/*

            for( i=0;i<5;i++)
            {
                ctx.moveTo( canvas.centroid[0], canvas.centroid[1]);
                ctx.lineTo(canvas.x_out[i],canvas.y_out[i]);
            }
*/

            ctx.stroke();

          ctx.strokeStyle=Qt.rgba(0.3,0.7,1.0,0.3);

            ctx.moveTo(canvas.x_in[0],canvas.y_in[0]);

            for(i=1;i<=5;i++)
            {
                ctx.lineTo(canvas.x_in[i%5],canvas.y_in[i%5]);
            }


            ctx.stroke();

            ctx.fillStyle=Qt.rgba(0,0,0,1.0);

            ctx.font="30px Arial";

            //draw label text

            var padrate=0.5;

            for( i=0;i<5;i++)
            {
                var x=(canvas.x_out[i]+canvas.x_out[(i+1)%5])/2;
                var y=(canvas.y_out[i]+canvas.y_out[(i+1)%5])/2;

                var vec_x=x-canvas.centroid[0];
                var vec_y=y-canvas.centroid[1];

                ctx.fillText(canvas.emo[i],x+vec_x*padrate,y+vec_y*padrate);


                //ctx.fillText(canvas.emo[i],canvas.x_out[i]-(canvas.x_in[i]-canvas.x_out[i])/2-10,canvas.y_out[i]-(canvas.y_in[i]-canvas.y_out[i])/2+10);


            }

            ctx.closePath();
            canvas.requestPaint();
            return ctx.getImageData(0,0,canvas.width,canvas.height);


            }

        Component.onCompleted: {

            canvas.base_img= draw_pentagonal();
            console.log("base_img:"+canvas.base_img.width+"x"+canvas.base_img.height+" "+canvas.base_img.data);


        }


    }


}


