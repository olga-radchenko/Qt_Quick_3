import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Window {
    id: root
    width: 320
    height: 480
    visible: true
    title:  qsTr("Login Form")

    Timer {id:timer}

    property string userName:""

    property int failLoginCounter: 0 /* После третьей неудачной попытки входа
    появится кнопка для вызова формы восстановления пароля */

    property ListModel loginList: LoginListModel {}

    LinearGradient {
       id: gradient
       start: Qt.point(50, 0)
       end: Qt.point(100, 480)
       anchors.fill: parent
       gradient: Gradient {
            GradientStop { position: 0.0; color: "#87ceeb" }
            GradientStop { position: 0.5; color: "#dda0dd" }
            GradientStop { position: 1.0; color: "#ff69b4" }
       }
       opacity: 0.6
    }

    Column {
        id:mainView
        spacing: 5
        width: root.width
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: logoPic
            width: 100
            height: 100
            anchors.horizontalCenter: parent.horizontalCenter
            source: "qrc:/LoginForm/LogoPic/logo.png"
            Layout.alignment: Qt.AlignHCenter
        }

        states: [
            State {
                name: "loginForm"
                PropertyChanges { target: loginForm; state: "Visible"}
            },
            State {
                name: "loginSuccess"
                PropertyChanges { target: loginForm; state: "Invisible"}
                PropertyChanges { target: welcomeForm; state: "Visible"}
            },
            State {
                name: "accountCreate"
                PropertyChanges { target: loginForm; state: "Invisible"}
                PropertyChanges { target: registrationForm; state: "Visible"}
            },
            State {
                name: "recoverRequest"
                PropertyChanges { target: loginForm; state: "Invisible"}
                PropertyChanges { target: pswRecoverForm; state: "Visible"}
            }
        ]

        LoginForm {
            id:loginForm
            anchors.horizontalCenter: parent.horizontalCenter
            state:"Invisible"
            onLoginSuccess: function (login) { mainView.state = "loginSuccess" ; userName = login ; }
            onAccountCreate:()=>{ mainView.state = "accountCreate" }
            onRecoverRequest:()=>{ mainView.state = "recoverRequest" }
        }

        RegistrationForm {
            id:registrationForm
            anchors.horizontalCenter: parent.horizontalCenter
            state:"Invisible"
            onBack:()=>{ mainView.state = "loginForm" }
            onRegistrationSuccess:()=>{ mainView.state = "loginForm" }
        }

        PswRecoverForm {
            id:pswRecoverForm
            anchors.horizontalCenter: parent.horizontalCenter
            state:"Invisible"
            onBack:()=>{ mainView.state = "loginForm" }
            onRecovered:()=>{ mainView.state = "loginForm" }
        }

        WelcomeForm {
            id:welcomeForm
            anchors.horizontalCenter: parent.horizontalCenter
            state:"Invisible"
            onLogout:()=>{ mainView.state = "loginForm"}
        }

        state:"loginForm"
    }

    function printUserRegisteredData(id) {
        console.log("Email:",loginList.get(id).email)
        console.log("Username:",loginList.get(id).username)
        console.log("Password:",loginList.get(id).password)
    }

    function findNamePswdCombination(username, password) {
        for(var i = 0; i < loginList.count; ++i) {
            if ((loginList.get(i).username === username) && (loginList.get(i).password === password))
            {
              return i
            }
        }
    return -1
    }

    function findEmail(email) {
        for(var i = 0; i < loginList.count; ++i) {
            if (loginList.get(i).email === email)
            {
              return i
            }
        }
    return -1
    }

    function findName(name) {
        for(var i = 0; i < loginList.count; ++i) {
            if (loginList.get(i).username === name)
            {
              return i
            }
        }
    return -1
    }
}
