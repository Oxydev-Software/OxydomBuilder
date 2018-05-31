import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

ScrollView {
    z: -1

    ListView {
        id: clientList
        model: clientModel
        width: stackView.width
        spacing: 5
        property int selected: 0
        delegate: Rectangle {
            Layout.preferredHeight: stackView.height * 0.3
            height: stackView.height / 6
            width: stackView.width
            MouseArea{
                height: parent.height
                width: parent.width
                onPressAndHold: {
                    clientMenu.x = mouseX
                    clientMenu.y = mouseY
                    clientList.selected = index
                    clientMenu.open()
                }
                onClicked: stackView.push(Qt.resolvedUrl("Projets.qml"),{nomObjet:"Projets"});
                RowLayout{
                    anchors.fill: parent
                    Item {
                        Layout.preferredWidth: parent.width * 0.05
                    }
                    Image {
                        // Layout.preferredWidth: parent.width * 0.1
                        Layout.alignment: Qt.AlignLeft
                        height: 100
                        width: 100
                        source: "../images/contacts.png"
                    }
                    Item {
                        Layout.preferredWidth: parent.width * 0.05
                    }
                    Text {
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.alignment: Qt.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        text:  nom + " " + prenom
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                }
                Menu {
                    id: clientMenu
                    MenuItem {
                        text: "Editer client"
                        onTriggered: {
                            clientPrenomEdit.text = clientModel.get(clientList.selected).prenom || ""
                            clientNomEdit.text = clientModel.get(clientList.selected).nom || ""
                            clientCiviliteEdit.text = clientModel.get(clientList.selected).civilite || ""
                            clientPaysEdit.text = clientModel.get(clientList.selected).pays || ""
                            clientVilleEdit.text = clientModel.get(clientList.selected).ville || ""
                            clientAdresseEdit.text = clientModel.get(clientList.selected).adresse || ""
                            clientTelEdit.text = clientModel.get(clientList.selected).tel || ""
                            clientEmailEdit.text = clientModel.get(clientList.selected).email || ""
                            editClientDialog.visible = true
                        }
                    }
                    MenuItem {
                        text: "Détails client"
                        onTriggered: {
                            clientPrenomDetail.text = "Prénom : " + clientModel.get(clientList.selected).prenom || ""
                            clientNomDetail.text = "Nom : " + clientModel.get(clientList.selected).nom || ""
                            clientCiviliteDetail.text = "Civilité : " + clientModel.get(clientList.selected).civilite || ""
                            clientPaysDetail.text = "Pays : " + clientModel.get(clientList.selected).pays || ""
                            clientVilleDetail.text = "Ville : " + clientModel.get(clientList.selected).ville || ""
                            clientAdresseDetail.text = "Adresse : " + clientModel.get(clientList.selected).adresse || ""
                            clientTelDetail.text = "Tel : " + clientModel.get(clientList.selected).tel || ""
                            clientEmailDetail.text = "Email : " + clientModel.get(clientList.selected).email || ""
                            detailsClientDialog.visible = true
                        }
                    }
                }
            }
        }
        RoundButton {
            text: "\u002B" // Unicode Character 'Plus Sign'
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            Material.background: Material.Red
            Material.foreground: "white"
            width: 60
            height: 60
            anchors.margins: 15
            font.pixelSize: 26
            onClicked: {
                clientPrenomAdd.text = ""
                clientNomAdd.text =  ""
                clientCiviliteAdd.text = ""
                clientPaysAdd.text = ""
                clientVilleAdd.text = ""
                clientAdresseAdd.text = ""
                clientTelAdd.text = ""
                clientEmailAdd.text = ""
                addClientDialog.visible = true
            }
        }
        Dialog {
            id: editClientDialog
            visible: false
            title: "Editer client"
            width: 350
            height: 500
            standardButtons: Dialog.Save | Dialog.Cancel
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            onAccepted: {
                clientModel.setProperty(clientList.selected,"prenom", clientPrenomEdit.text)
                clientModel.setProperty(clientList.selected,"nom", clientNomEdit.text)
                clientModel.setProperty(clientList.selected,"civilite", clientCiviliteEdit.text)
                clientModel.setProperty(clientList.selected,"pays", clientPaysEdit.text)
                clientModel.setProperty(clientList.selected,"ville", clientVilleEdit.text)
                clientModel.setProperty(clientList.selected,"adresse", clientAdresseEdit.text)
                clientModel.setProperty(clientList.selected,"tel", clientTelEdit.text)
                clientModel.setProperty(clientList.selected,"email", clientEmailEdit.text)
                editClientDialog.visible = false
            }
            contentItem: ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                TextField {
                    id: clientPrenomEdit
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Prénom")
                }

                TextField {
                    id: clientNomEdit
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Nom")
                }

                TextField {
                    id: clientCiviliteEdit
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Civilité")
                }

                TextField {
                    id: clientPaysEdit
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Pays")
                }

                TextField {
                    id: clientVilleEdit
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Ville")
                }

                TextField {
                    id: clientAdresseEdit
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Adresse")
                }

                TextField {
                    id: clientTelEdit
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Telephone")
                }

                TextField {
                    id: clientEmailEdit
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("E-mail")
                }

            }

        }
        Dialog {
            id: addClientDialog
            visible: false
            title: "Ajouter client"
            width: 350
            height: 500
            standardButtons: Dialog.Save | Dialog.Cancel
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            onAccepted: {
                clientModel.append({
                                       "prenom": clientPrenomAdd.text,
                                       "nom": clientNomAdd.text,
                                       "civilite" : clientCiviliteAdd.text,
                                       "pays": clientPaysAdd.text,
                                       "ville": clientVilleAdd.text,
                                       "adresse": clientAdresseAdd.text,
                                       "tel": clientTelAdd.text,
                                       "email": clientEmailAdd.text,
                                   })
            }
            contentItem: ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                TextField {
                    id: clientPrenomAdd
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Prénom")
                }

                TextField {
                    id: clientNomAdd
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Nom")
                }

                TextField {
                    id: clientCiviliteAdd
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Civilité")
                }

                TextField {
                    id: clientPaysAdd
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Pays")
                }

                TextField {
                    id: clientVilleAdd
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Ville")
                }

                TextField {
                    id: clientAdresseAdd
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Adresse")
                }

                TextField {
                    id: clientTelAdd
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Telephone")
                }

                TextField {
                    id: clientEmailAdd
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("E-mail")
                }

            }

        }

        Dialog {
            id: detailsClientDialog
            visible: false
            title: "Détails client"
            width: 350
            height: 500
            standardButtons: null | Dialog.Close
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            contentItem: ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Label {
                    id: clientPrenomDetail
                    font.pointSize: 15
                    Layout.fillWidth: true
                    text: "Prénom"
                }

                Label {
                    id: clientNomDetail
                    font.pointSize: 15
                    Layout.fillWidth: true
                    text: "Nom"
                }

                Label {
                    id: clientCiviliteDetail
                    font.pointSize: 15
                    Layout.fillWidth: true
                    text: "Civilité"
                }

                Label {
                    id: clientPaysDetail
                    font.pointSize: 15
                    Layout.fillWidth: true
                    text: "Pays"
                }

                Label {
                    id: clientVilleDetail
                    font.pointSize: 15
                    Layout.fillWidth: true
                    text: "Ville"
                }

                Label {
                    id: clientAdresseDetail
                    font.pointSize: 15
                    Layout.fillWidth: true
                    text: "Adresse"
                }

                Label {
                    id: clientTelDetail
                    font.pointSize: 15
                    Layout.fillWidth: true
                    text: "Telephone"
                }

                Label {
                    id: clientEmailDetail
                    font.pointSize: 15
                    Layout.fillWidth: true
                    text: "E-mail"
                }

            }

        }

        ListModel {
            id: clientModel

            ListElement {
                prenom:"Mary"
                nom: "Johnson"
                civilite: ""
                pays: ""
                ville: ""
                adresse: ""
                tel: ""
                email: ""
            }

            ListElement {
                prenom:"Peter"
                nom: "Carlsson"
                civilite: ""
                pays: ""
                ville: ""
                adresse: ""
                tel: ""
                email: ""
            }

            ListElement {
                prenom:"Trevor"
                nom: "Hansen"
                civilite: ""
                pays: ""
                ville: ""
                adresse: ""
                tel: ""
                email: ""
            }

            ListElement {
                prenom:"Abbey"
                nom: "Christensen"
                civilite: ""
                pays: ""
                ville: ""
                adresse: ""
                tel: ""
                email: ""
            }

            ListElement {
                prenom:"Ali Mary"
                nom: "Connors"
                civilite: ""
                pays: ""
                ville: ""
                adresse: ""
                tel: ""
                email: ""
            }
            ListElement {
                prenom:"Mary"
                nom: "Johnson"
                civilite: ""
                pays: ""
                ville: ""
                adresse: ""
                tel: ""
                email: ""
            }

            ListElement {
                prenom:"Peter"
                nom: "Carlsson"
                civilite: ""
                pays: ""
                ville: ""
                adresse: ""
                tel: ""
                email: ""
            }

            ListElement {
                prenom:"Trevor"
                nom: "Hansen"
                civilite: ""
                pays: ""
                ville: ""
                adresse: ""
                tel: ""
                email: ""
            }

            ListElement {
                prenom:"Abbey"
                nom: "Christensen"
                civilite: ""
                pays: ""
                ville: ""
                adresse: ""
                tel: ""
                email: ""
            }

            ListElement {
                prenom:"Ali Mary"
                nom: "Connors"
                civilite: ""
                pays: ""
                ville: ""
                adresse: ""
                tel: ""
                email: ""
            }
        }
    }
}
