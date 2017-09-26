import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: item1

    property alias stsp_button: stsp_button
    property alias emo_predict: emo_predict
    property alias columnLayout: columnLayout
    property alias canvas: canvas
    property alias canvasMsAr: canvasMsAr

    ColumnLayout {
        id: columnLayout
        x: 0
        y: 0
        width: 640
        height: 480

        Text {
            id: emo_predict
            width: 92
            height: 80
            text: "Emotion"
            topPadding: 6
            leftPadding: 3
            Layout.columnSpan: 1
            Layout.rowSpan: 1
            font.pixelSize: 31
            padding: -1
            font.weight: Font.Light
            style: Text.Normal
            font.family: "Arial"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            opacity: 1
            clip: true
            visible: true
            Layout.fillHeight: false
            Layout.fillWidth: false
        }

        Canvas {
            id: canvas
            property var base_img: null
            property var x_out: new Array(5)
            property var y_out: new Array(5)
            property var x_in: new Array(5)
            property var y_in: new Array(5)
            property var emo: new Array(5)
            property var centroid: new Array(2)
            property var radius: 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: emo_predict.bottom
            anchors.bottom: stsp_button.top
            anchors.margins: 8
            property real lastX
            property real lastY
            //  property color color: colorTools.paintColor ;
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            MouseArea {
                id: canvasMsAr
                anchors.fill: parent
            }
        }


        Button {
            id: stsp_button
            text: "Start"
            bottomPadding: 6
            Layout.fillHeight: false
            antialiasing: false
            transformOrigin: Item.Center
            Layout.fillWidth: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBaseline
        }

    }

    /*
    RowLayout {
        x: 195
        y: 124
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 19
        anchors.top: parent.top

        TextField {
            id: textField1
            placeholderText: qsTr("Text Field")
        }

        Button {
            id: button1
            text: qsTr("Start")
        }
    }
*/
}
