import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

Item {
    id: login
    width: parent.width
    height: parent.height

    ColumnLayout {
        id: columnLayout
        width: 350
        height: 250
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter


        Label {
            text: qsTr("Oxydom Builder")
            font.weight: Font.ExtraBold
            font.capitalization: Font.AllUppercase
            font.italic: false
            font.bold: false
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pointSize: 15
            Layout.fillWidth: true
        }

        TextField {
            id: utilisateur
            font.pointSize: 15
            Layout.fillWidth: true
            placeholderText: qsTr("Identifiant")
            text: backend.userName
            onTextChanged: backend.userName = text
        }

        TextField {
            id: mdp
            clip: false
            renderType: Text.QtRendering
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 15
            Layout.fillWidth: true
            placeholderText: qsTr("Mot de passe")
            echoMode: TextInput.Password
            passwordMaskDelay: 100

        }

        Button {
            id: submit
            text: qsTr("Se connecter")
            font.pointSize: 15
            spacing: -2
            font.capitalization: Font.MixedCase
            Layout.fillWidth: true
            highlighted: false
            Material.background: Material.Blue
            Material.foreground: "#fff"
            onClicked: {
                toolbar.visible= true
                stackView.push(Qt.resolvedUrl("Clients.qml"),{nomObjet:"Clients"});
            }
        }

    }

}
