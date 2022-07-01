import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: welcomeForm
    width: 320
    height: 360

    signal logout()

    states: [
        State{
            name: "Visible"
            PropertyChanges{target: welcomeForm; opacity: 1.0}
            PropertyChanges{target: welcomeForm; visible: true}
        },
        State{
            name:"Invisible"
            PropertyChanges{target: welcomeForm; opacity: 0.0}
            PropertyChanges{target: welcomeForm; visible: false}
        }
    ]

    transitions: [
        Transition {
            from: "Visible"
            to: "Invisible"

            SequentialAnimation{
               NumberAnimation {
                   target: welcomeForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
               }
               NumberAnimation {
                   target: welcomeForm
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
                    target: welcomeForm
                    duration: 1000
                }
                NumberAnimation {
                   target: welcomeForm
                   property: "visible"
                   duration: 0
               }
                NumberAnimation {
                   target: welcomeForm
                   property: "opacity"
                   duration: 1000
                   easing.type: Easing.InOutQuad
                }
            }
        }
    ]

    ColumnLayout {
        anchors.fill: parent
        Label {
            id: label
            text: `Hello, ${userName}!`
            font.italic: false
            font.weight: Font.Thin
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            font.pointSize: 24
            font.family: "MV Boli"
        }
        Row {
            id: row
            width: 260
            height: 50
            Layout.bottomMargin: -20
            Layout.leftMargin: 265
            layoutDirection: Qt.LeftToRight
            Button {
                id: logoutBttn
                width: 50
                height: 50
                Layout.bottomMargin: 20
                Layout.rightMargin: 10
                background: Rectangle {
                    color: "transparent"
                    Image {
                        id: logoutPic
                        width: 50
                        height: 50
                        source: "qrc:/LoginForm/LogoPic/logout.png"
                    }
                }
                onClicked: { welcomeForm.logout() }
            }
        }
    }
}

/*##^##
Designer {
    D{i:16;anchors_height:100;anchors_width:100;anchors_x:80;anchors_y:40}
}
##^##*/
