import QtQuick 2.0
import QtCharts 2.2
Item {
    width: parent.width;
    height:parent.height;
      property int point_num: 16000

    property alias chartView: chartView
    ChartView{
        id:chartView
        anchors.fill:parent
        antialiasing:true
        animationOptions:ChartView.SeriesAnimations



        ValueAxis{
            id:axis_y
            min:-0.05
            max:0.05
        }
        ValueAxis{
            id:axis_x
            min:0
            max:point_num
        }

        LineSeries{
            id:lineSeries
            width: 0.5
            capStyle: Qt.RoundCap
            color:'red'
            name:"wave_signal"
            axisX:axis_x
            axisY:axis_y
            useOpenGL: true
        }

        Component.onCompleted: {
            ser_engine.update(lineSeries)
        }




    }
}
