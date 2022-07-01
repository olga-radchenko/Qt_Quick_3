import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: loginForm
    width: 260
    height: 180

    property int current_x: mainRect.x

    signal loginSuccess(string login)
    signal accountCreate()
    signal recoverRequest()

    states: [
        State{
            name: "Visible"
            PropertyChanges{target: loginForm; opacity: 1.0}
            PropertyChanges{target: loginForm; visible: true}
        },
        State{
            name:"Invisible"
            PropertyChanges{target: loginForm; opacity: 0.0}
            PropertyChanges{target: loginForm; visible: false}
        }
    ]

    transitions: [
        Transition {
            from: "Visible"
            to: "Invisible"

            SequentialAnimation{
               NumberAnimation {
                   target: loginForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
               }
               NumberAnimation {
                   target: loginForm
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
                    target: loginForm
                    duration: 1000
                }
                NumberAnimation {
                   target: loginForm
                   property: "visible"
                   duration: 0
               }
                NumberAnimation {
                   target: loginForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
                }
            }
        }
    ]

    ParallelAnimation {
        id: failAnimation
        SequentialAnimation {
            PropertyAnimation {
                targets: [usrnameLabel, usrswrdLabel]
                property: "color"
                to: "red"
                duration: 400
            }
            PropertyAnimation {
                targets: [usrnameLabel, usrswrdLabel]
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
            "x"; to: current_x; duration: 50    }
        }
    }

    Rectangle {
        id:mainRect
        Layout.alignment: Qt.AlignHCenter
        width: parent.width
        height: parent.height
        color: "white"
        radius: 10
        opacity: 0.5
    }

    ColumnLayout {
        id: mainColumn
        spacing: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter

        RowLayout {
            spacing: 10
            Column {
                id: column
                width: 55
                spacing: 10
                Label {
                    id:usrnameLabel
                    text:"Login:"
                    font.pointSize: 9
                    horizontalAlignment: Text.AlignRight
                    width: 55
                    font.family: "MV Boli"
                }
                Label {
                    id:usrswrdLabel
                    text:"Password:"
                    font.pointSize: 9
                    width: 55
                    font.family: "MV Boli"
                }
            }
            Column {
                spacing: 10
                Layout.fillWidth: true

                TextField {
                    id:usr_login;
                    width: 175
                    background: Rectangle {
                        color: "white"
                        opacity: 0.9
                        radius: 10
                    }
                    onAccepted: enterBttn.clicked()
                }
                TextField {
                    id:usr_psswrd;
                    echoMode: TextInput.Password
                    width: 175
                    background: Rectangle {
                        color: "white"
                        opacity: 0.9
                        radius: 10
                    }
                    onAccepted: enterBttn.clicked()
                }
            }
        }
        RowLayout {
            width: mainColumn.width
            Layout.fillWidth: true
            Layout.preferredHeight:20
            Button {
                id: enterBttn
                height: 20
                text: "Login"
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height
                font.pointSize: 9
                font.family: "MV Boli"
                Layout.alignment: Qt.AlignHCenter

                background: Rectangle {
                    id: bttnRect
                    color: "#ff69b4"
                    opacity: 0.7
                    radius: 5
                    anchors.fill: parent
                }
                onPressed:  { bttnRect.color = "#dda0dd" }
                onReleased: { bttnRect.color = "#ff69b4" }
                onClicked:
                {
                    if(findNamePswdCombination(usr_login.text, usr_psswrd.text) !== -1)
                    {
                           loginForm.loginSuccess(usr_login.text)
                    }
                    else { failAnimation.start() }
                }
            }
        }

        RowLayout {
            width: mainColumn.width
            Layout.fillWidth: true
            Layout.preferredHeight:20
            Label {
                id: label
                font.pointSize: 9
                font.family: "MV Boli"
                text: qsTr("Not registered yet?")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillHeight: true
            }

            Button {
                contentItem: Text {
                    id:regBttnText
                    text:"Create an account"
                    color: "#ff69b4"
                    font.pointSize: 9
                    font.family: "MV Boli"
                    font.underline: true
                }

                background: Rectangle {
                    color: "transparent"
                    anchors.fill: parent
                }

                onPressed:  { regBttnText.color = "#dda0dd" }
                onReleased: { regBttnText.color = "#ff69b4" }
                onClicked:  { loginForm.accountCreate()     }
            }
        }

        RowLayout {
            width: mainColumn.width
            Layout.fillWidth: true
            Layout.preferredHeight:20
            Button {
                id: forgotBttn
                Layout.fillWidth: true

                contentItem: Text {
                    id:forgotBttnText
                    text:"Forgot your password?"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#ff69b4"
                    font.pointSize: 9
                    font.family: "MV Boli"
                    font.underline: true
                }
                background: Rectangle {
                    color: "transparent"
                    radius: 5
                    anchors.fill: parent
                }

                onPressed:  { forgotBttnText.color = "#dda0dd" }
                onReleased: { forgotBttnText.color = "#ff69b4" }
                onClicked:  { loginForm.recoverRequest()       }
            }
        }
    }
}



