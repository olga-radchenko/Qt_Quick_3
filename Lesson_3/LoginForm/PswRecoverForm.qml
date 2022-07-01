import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: pswRecoverForm
    width: 260
    height: 180

    property int current_x: mainRect.x

    signal recovered()
    signal back()

    states: [
        State{
            name: "Visible"
            PropertyChanges{target: pswRecoverForm; opacity: 1.0}
            PropertyChanges{target: pswRecoverForm; visible: true}
        },
        State{
            name:"Invisible"
            PropertyChanges{target: pswRecoverForm; opacity: 0.0}
            PropertyChanges{target: pswRecoverForm; visible: false}
        }
    ]

    transitions: [
        Transition {
            from: "Visible"
            to: "Invisible"

            SequentialAnimation {
               NumberAnimation {
                   target: pswRecoverForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
               }
               NumberAnimation {
                   target: pswRecoverForm
                   property: "visible"
                   duration: 0
               }
            }
        },
        Transition {
            from: "Invisible"
            to: "Visible"
            SequentialAnimation {
                NumberAnimation {
                    target: pswRecoverForm
                    duration: 1000
                }
                NumberAnimation {
                   target: pswRecoverForm
                   property: "visible"
                   duration: 0
                }
                NumberAnimation {
                   target: pswRecoverForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
                }
            }
        }
    ]

    Rectangle {
        id:mainRect
        Layout.alignment: Qt.AlignHCenter
        width: parent.width
        height: parent.height
        color: "white"
        radius: 10
        opacity: 0.5

        ParallelAnimation {
            id: failAnimation
            SequentialAnimation {
                PropertyAnimation {
                    targets: [ oldUsrMailLabel ]
                    property: "color"
                    to: "red"
                    duration: 400
                }
                PropertyAnimation {
                    targets: [ oldUsrMailLabel ]
                    property: "color"
                    to: "black"
                    duration: 400
                }
            loops: 2
            }

            SequentialAnimation {
                NumberAnimation { target: mainRect; property:
                "x"; to: current_x-5; duration: 50 }
                NumberAnimation { target: mainRect; property:
                "x"; to: current_x+5; duration: 100 }
                NumberAnimation { target: mainRect; property:
                "x"; to: current_x; duration: 50 }
            }
        }
    }
    RowLayout {
        width: 240
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.alignment: Qt.AlignHCenter
        Label {
            id:oldUsrMailLabel
            text:"Enter username or registration email:"
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            font.pointSize: 9
            horizontalAlignment: Text.AlignHCenter
            font.family: "MV Boli"
        }
    }
    RowLayout {
        width: 240
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.fillWidth: true
        TextField {
            id:oldUsrField;
            width: 240
            Layout.fillWidth: true
            background: Rectangle {
                color: "white"
                opacity: 0.9
                radius: 10
            }
            onAccepted: acceptBttn.clicked()
        }
    }
    RowLayout {
        width: 240
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 110
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.fillWidth: true

        Label {
            id:sendNewPswdLabel
            width: 240
            height: 40
            text:'<font>If this user exists, we have sent you a password reset on <del>Email</del> console </font> :)'
            Layout.fillHeight: true
            Layout.fillWidth: true
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            font.pointSize: 9
            horizontalAlignment: Text.AlignHCenter
            font.family: "MV Boli"
            opacity: 0
            states: [
                State {
                name: "labelInvisible"
                PropertyChanges { target: sendNewPswdLabel; opacity: 0 }},

                State {
                name: "labelVisible"
                PropertyChanges { target: sendNewPswdLabel; opacity: 1 }}
            ]

            transitions: [
                Transition {
                to: "labelVisible";
                NumberAnimation { property: "opacity"; duration: 1000 }},
                Transition {
                to: "labelInvisible";
                NumberAnimation { property: "opacity"; duration: 1 }} ]
            }
        }

    RowLayout {
        width: 240
        height: 20
        anchors.top: parent.top
        anchors.topMargin: 80
        anchors.horizontalCenter: parent.horizontalCenter
        Button {
            id:acceptBttn
            width: 240
            height: 20
            text: "Change password"
            font.pointSize: 9
            font.family: "MV Boli"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            background: Rectangle {
                id:acceptBttnRect
                color: "#ff69b4"
                opacity: 0.7
                radius: 5
                anchors.fill: parent
            }
            onPressed: {
                acceptBttnRect.color = "#dda0dd"
            }
            onReleased: {
                acceptBttnRect.color = "#ff69b4"
            }
            onClicked: {
                if(oldUsrField.text == "") { failAnimation.start() }
                else {
                    if(findEmail(oldUsrField.text) !== -1) {
                        printUserRegisteredData(findEmail(oldUsrField.text))
                    }
                    else if(findName(oldUsrField.text) !== -1) {
                        printUserRegisteredData(findName(oldUsrField.text))
                    }
                    sendNewPswdLabel.state = "labelVisible"
                    timer.interval = 5000;
                    timer.triggered.connect(function () {
                        pswRecoverForm.recovered()
                        sendNewPswdLabel.state = "labelInvisible"
                        oldUsrField.text = ""
                    })
                    timer.start()
                }
            }
        }
        Button {
            height: 20
            text: "Back"
            font.pointSize: 9
            font.family: "MV Boli"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            background: Rectangle {
                id:backBttnRect
                color: "#ff69b4"
                opacity: 0.7
                radius: 5
                anchors.fill: parent
            }
            onPressed:  { backBttnRect.color = "#dda0dd" }
            onReleased: { backBttnRect.color = "#ff69b4" }
            onClicked:  { pswRecoverForm.back(); oldUsrField.text = ""}
        }
    }
}
