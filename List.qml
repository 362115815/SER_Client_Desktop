import QtQuick 2.7
import QtQuick.Controls 1.4
import QtMultimedia 5.8

Item {
    width: parent.width;
    height:600;

    property alias emoModel: emoModel
    property real tableWidth: 800;
    property real singleLineHeight: 25;
    property int  c_index: 10;
    MediaPlayer{
        id:player;
        autoPlay: false;
    }

    TableView{
        id:emoTable;
        anchors.fill: parent;
        model:ListModel{
            id:emoModel;
            /*
            ListElement{
                voice_seg:"dfdfd";
                emotion:"dfdf";
            }
            ListElement{
                voice_seg:"dfdfdfdf";
                emotion:"dffdddffdfdf";
            }
            */
        }

        headerDelegate: headerDele;
        rowDelegate:rowDele;

        //定义表头delegate
        Component{
            id:headerDele;
            Rectangle{
                implicitWidth: tableWidth*0.1;
                implicitHeight: 25;
                color:"#F15454";
                Text{
                    text:styleData.value;
                    anchors.centerIn: parent;
                    padding: -1
                    font.weight: Font.Light
                    style: Text.Normal
                    font.family: "Arial"
                }

            }
        }

        //定义行的delegate
        Component{
            id:rowDele;
            Rectangle{
                id:rect1;
                width:tableWidth;
                height: singleLineHeight;

               // color:styleData.selected? "#450000ff":"#22000000";

                MouseArea{
                    anchors.fill: parent;

                    onDoubleClicked: {
                      var wav_seg_path=ser_engine.get_wav_seg_path();
                      var index=styleData.row;
                      var voice_seg=emoModel.get(index).voice_seg;
                      var wav_file=wav_seg_path+"/"+voice_seg+"_done.wav";

                       player.source=wav_file;
                       player.play();
                       console.log(emoModel.get(index).voice_seg);
                       console.log(wav_file);
                       console.log("styleData.alternate="+styleData.alternate);
                       console.log("styleData.selected="+styleData.selected);
                       console.log("styleData.row="+styleData.row);
                       console.log("styleData.hasActiveFocus="+styleData.hasActiveFocus);
                       console.log("styleData.pressed="+styleData.pressed);

                    }

                }


            }
        }

        TableViewColumn{
            role:"voice_seg";
            title:"Voice Segment";
            width: parent.width/2;
            //elideMode: Text.ElideMiddle;
            delegate: Rectangle{
                height: singleLineHeight;
                color: "transparent";
                Text{
                    anchors.centerIn: parent;
                    text:styleData.value;
                    padding: -1
                    font.weight: Font.Light
                    style: Text.Normal
                    font.family: "Arial"
                }
            }






        }
        TableViewColumn{
            role: "emotion";
            title:"Emotion";
            width:parent.width/2;
            //elideMode: Text.ElideMiddle;
            delegate: Rectangle{
                height: singleLineHeight;
                color: "transparent";
                Text{
                    anchors.centerIn: parent;
                    text:styleData.value;
                    padding: -1
                    font.weight: Font.Light
                    style: Text.Normal
                    font.family: "Arial"
                }
            }
        }

        horizontalScrollBarPolicy:Qt.ScrollBarAlwaysOff;
        verticalScrollBarPolicy: Qt.ScrollBarAsNeeded;

        focus: true;
    }





}
