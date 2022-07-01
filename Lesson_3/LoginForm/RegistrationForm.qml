import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: registrationForm
    width: 260
    height: 180

    property int current_x: mainRect.x

    signal registrationSuccess()
    signal back()

    states: [
        State{
            name: "Visible"
            PropertyChanges{target: registrationForm; opacity: 1.0}
            PropertyChanges{target: registrationForm; visible: true}
        },
        State{
            name:"Invisible"
            PropertyChanges{target: registrationForm; opacity: 0.0}
            PropertyChanges{target: registrationForm; visible: false}
        }
    ]

    transitions: [
        Transition {
            from: "Visible"
            to: "Invisible"

            SequentialAnimation {
               NumberAnimation {
                   target: registrationForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
               }
               NumberAnimation {
                   target: registrationForm
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
                    target: registrationForm
                    duration: 1000
                }
                NumberAnimation {
                   target: registrationForm
                   property: "visible"
                   duration: 0
                }
                NumberAnimation {
                   target: registrationForm
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
            id: failEmailAnimation
            PropertyAnimation {
                targets: [warningLabel]
                property: "opacity"
                to: 1
                duration: 400
            }
            ParallelAnimation {
                SequentialAnimation {
                    PropertyAnimation {
                        targets: [newUsrMailLabel, warningLabel]
                        property: "color"
                        to: "red"
                        duration: 400
                    }
                    PropertyAnimation {
                        targets: [newUsrMailLabel, warningLabel]
                        property: "color"
                        to: "black"
                        duration: 400
                    }
                loops: 2
                }
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

        ParallelAnimation {
            id: failNameAnimation
            PropertyAnimation {
                targets: [warningLabel]
                property: "opacity"
                to: 1
                duration: 400
            }
            ParallelAnimation {
                SequentialAnimation {
                    PropertyAnimation {
                        targets: [newUsrNameLabel, warningLabel]
                        property: "color"
                        to: "red"
                        duration: 400
                    }
                    PropertyAnimation {
                        targets: [newUsrNameLabel, warningLabel]
                        property: "color"
                        to: "black"
                        duration: 400
                    }
                loops: 2
                }
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

        ParallelAnimation {
            id: failPswAnimation
            PropertyAnimation {
                targets: [warningLabel]
                property: "opacity"
                to: 1
                duration: 400
            }
            ParallelAnimation {
                SequentialAnimation {
                    PropertyAnimation {
                        targets: [newUsrPswrdLabel_1, newUsrPswrdLabel_2, warningLabel]
                        property: "color"
                        to: "red"
                        duration: 400
                    }
                    PropertyAnimation {
                        targets: [newUsrPswrdLabel_1, newUsrPswrdLabel_2, warningLabel]
                        property: "color"
                        to: "black"
                        duration: 400
                    }
                loops: 2
                }
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

        ParallelAnimation {
            id: failEmptyAnimation
            PropertyAnimation {
                targets: [warningLabel]
                property: "opacity"
                to: 1
                duration: 400
            }
            ParallelAnimation {
                SequentialAnimation {

                    PropertyAnimation {
                        targets: [newUsrMailLabel, newUsrNameLabel, newUsrPswrdLabel_1, newUsrPswrdLabel_2, warningLabel]
                        property: "color"
                        to: "red"
                        duration: 400
                    }
                    PropertyAnimation {
                        targets: [newUsrMailLabel, newUsrNameLabel, newUsrPswrdLabel_1, newUsrPswrdLabel_2, warningLabel]
                        property: "color"
                        to: "black"
                        duration: 400
                    }
                loops: 2
                }
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

    Label {
        id:warningLabel
        width: 240
        text:""
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.fillHeight: true
        Layout.fillWidth: true
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        font.pointSize: 8
        horizontalAlignment: Text.AlignHCenter
        font.family: "MV Boli"
        opacity: 0
    }

    RowLayout {
        width: 240
        anchors.top: parent.top
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.alignment: Qt.AlignHCenter
        spacing: 10.1
        Column {
            width: 55
            height: 135
            spacing: 10
            Label {
                id:newUsrMailLabel
                text:"Email:"
                font.pointSize: 9
                horizontalAlignment: Text.AlignRight
                width: 55
                font.family: "MV Boli"
            }

            Label {
                id:newUsrNameLabel
                text:"Login:"
                font.pointSize: 9
                horizontalAlignment: Text.AlignRight
                width: 55
                font.family: "MV Boli"
            }
            Label {
                id:newUsrPswrdLabel_1
                text:"Password:"
                font.pointSize: 9
                width: 55
                font.family: "MV Boli"
            }
            Label {
                id:newUsrPswrdLabel_2
                text:"Password:"
                font.pointSize: 9
                width: 55
                font.family: "MV Boli"
            }
        }
        Column {
            width: 175
            height: 135
            spacing: 5
            Layout.fillWidth: true
            TextField {
                id:newUsrMailField;
                width: 175
                background: Rectangle {
                    color: "white"
                    opacity: 0.9
                    radius: 10
                }
                onAccepted: regBttn.clicked()
            }
            TextField {
                id:newUsrNameField;
                width: 175
                background: Rectangle {
                    color: "white"
                    opacity: 0.9
                    radius: 10
                }
                onAccepted: regBttn.clicked()
            }
            TextField {
                id:newUsrPswrdField_1;
                echoMode: TextInput.Password
                width: 175
                background: Rectangle {
                    color: "white"
                    opacity: 0.9
                    radius: 10
                }
                onAccepted: regBttn.clicked()
            }
            TextField {
                id:newUsrPswrdField_2;
                echoMode: TextInput.Password
                width: 175
                background: Rectangle {
                    color: "white"
                    opacity: 0.9
                    radius: 10
                }
                onAccepted: regBttn.clicked()
            }
        }
    }

    RowLayout {
        width: 240
        height: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 7
        anchors.horizontalCenter: parent.horizontalCenter
        Button {
            id:regBttn
            height: 20
            text: "Register new user"
            font.pointSize: 9
            font.family: "MV Boli"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            background: Rectangle {
                id:regBttnRect
                color: "#ff69b4"
                opacity: 0.7
                radius: 5
                anchors.fill: parent
            }

            onPressed:  { regBttnRect.color = "#dda0dd" }
            onReleased: { regBttnRect.color = "#ff69b4" }
            onClicked:
            {
                if((newUsrMailField.text == "")||(newUsrNameField.text == "")||(newUsrPswrdField_1.text == ""))
                {
                    warningLabel.text = "All fields must be filled!"
                    failEmptyAnimation.start()
                }
                else if(findEmail(newUsrMailField.text) !== -1)
                {
                    warningLabel.text = "User with this is email already existed!"
                    failEmailAnimation.start()
                }
                else if(findName(newUsrNameField.text) !== -1)
                {
                    warningLabel.text = "User with this is name already existed!"
                    failNameAnimation.start()
                }
                else if(newUsrPswrdField_1.text !== newUsrPswrdField_2.text)
                {
                    warningLabel.text = "Passwords do not match!"
                    failPswAnimation.start()
                }
                else {
                    loginList.append({  email:    newUsrMailField.text,
                                        username: newUsrNameField.text,
                                        password: newUsrPswrdField_1.text })
                    registrationForm.registrationSuccess()
                    warningLabel.opacity = 0
                    eraseAllFields();
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
            onClicked:  { eraseAllFields(); registrationForm.back() }
        }
    }

    function eraseAllFields() {
        newUsrMailField.text = ""
        newUsrNameField.text = ""
        newUsrPswrdField_1.text = ""
        newUsrPswrdField_2.text = ""
    }
}


