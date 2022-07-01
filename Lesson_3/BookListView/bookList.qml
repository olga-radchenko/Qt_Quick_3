import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Window {
    id: root
    width: 320
    height: 480
    visible: true
    title:  qsTr("List Model Example")

    LinearGradient {
       id: gradient
       anchors.fill: parent
       start: Qt.point(0, 0)
       end: Qt.point(0, parent.height)
       gradient: Gradient {
            GradientStop { position: 0.0; color: "#f0fff0" }
            GradientStop { position: 0.5; color: "#66cdaa" }
            GradientStop { position: 1.0; color: "#008080" }
       }
       opacity: 0.6
    }

    ListView {
        id: listView
        width: 320
        height: 480
        ScrollBar.vertical: scrollBar
        model: BookListModel {}

        header: Rectangle {
            width: parent.width
            height: 20
            color:"#66cdaa"
            opacity: 0.8
            Text {
                anchors.centerIn: parent
                text: "Список литературы для чтения летом (9 класс)"
            }
        }

        footer: Rectangle {
            width: parent.width
            height:20
            color:"#66cdaa"
            opacity: 0.8
            Text {
                anchors.centerIn: parent
                text:"Приложение разработано Радченко О."
            }
        }

        section.delegate: Rectangle {

            width: parent.width
            height: 20
            color:"#66cdaa"
            opacity: 0.8
            Text {
                anchors.centerIn: parent
                text: section
                font.weight: Font.Bold
            }
        }

        section.property: "genre"

        delegate: Rectangle {

            width: listView.width
            height: 150
            color:"transparent"
            MouseArea {
                anchors.fill: parent
                onDoubleClicked: {
                    listView.model.remove(index)
                }
            }
            Column {
                Row {
                    spacing: 5
                    Column {
                        Image {
                            id: image
                            width: 100
                            height: 150
                            source: cover
                        }
                    }

                    Column {
                        y:5
                        spacing: 5
                        Row {
                            Text { text: "Автор: "; font.weight: Font.Bold}
                            Text { text: autor }
                        }
                        Row {
                            Text { text: "Название: "; font.weight: Font.Bold}
                            Text { text: name }
                        }
                    }
                }
            }
        }
    }

    ScrollBar {
        id: scrollBar
        width: 15
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        contentItem: Rectangle {
            implicitWidth: 20
            implicitHeight: 20
            border.width: 1
            border.color:"#008080"
            color: "#66cdaa"
            opacity: 0.8
        }
    }
}
