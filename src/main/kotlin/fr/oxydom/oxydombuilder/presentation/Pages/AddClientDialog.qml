import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

Item {
    Dialog {
        id: addClientDialog
        visible: false
        title: "Ajouter client"
        width: 350
        height: 450
        standardButtons: Dialog.Save | Dialog.Cancel
        x: (stackView.width - width) / 2
        y: (stackView.height - height) / 2
        onAccepted: {
            clientModel.append({"nom": AddClientDialog.clientNomAdd.text,
                                   "prénom": clientPrénomAdd.text,
                                   "tel": clientTelAdd.text,
                                   "adresse": clientAdresseAdd.text,
                                   "ville": clientVilleAdd.text,
                                   "département": clientDépartementAdd.text,
                                   "email": clientEmailAdd.text
                               })
        }
        contentItem: ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            TextField {
                id: clientNomAdd
                font.pointSize: 15
                Layout.fillWidth: true
                placeholderText: qsTr("Nom")
            }

            TextField {
                id: clientPrénomAdd
                font.pointSize: 15
                Layout.fillWidth: true
                placeholderText: qsTr("Prénom")
            }

            TextField {
                id: clientTelAdd
                font.pointSize: 15
                Layout.fillWidth: true
                placeholderText: qsTr("Telephone")
            }

            TextField {
                id: clientAdresseAdd
                font.pointSize: 15
                Layout.fillWidth: true
                placeholderText: qsTr("Adresse")
            }

            TextField {
                id: clientVilleAdd
                font.pointSize: 15
                Layout.fillWidth: true
                placeholderText: qsTr("Ville")
            }

            TextField {
                id: clientDépartementAdd
                font.pointSize: 15
                Layout.fillWidth: true
                placeholderText: qsTr("Département")
            }

            TextField {
                id: clientEmailAdd
                font.pointSize: 15
                Layout.fillWidth: true
                placeholderText: qsTr("E-mail")
            }

        }

    }

}
