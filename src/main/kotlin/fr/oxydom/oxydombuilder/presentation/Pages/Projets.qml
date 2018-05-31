import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtQuick.Controls.Styles 1.4

ScrollView {
    z: -1
    padding: 20

    Flow
    {
        id: flow
        width: mainWindow.width
        height: 800
        spacing: 20
        property int selected: 0
        Repeater
        {
            model: projetModel
            Rectangle
            {
                height: parent.height /6
                width: 250
                border.color: "black"
                Column {
                    id: card
                    anchors.fill: parent
                    Rectangle {
                        MouseArea{
                            height: parent.height
                            width: parent.width
                            onClicked: stackView.push(Qt.resolvedUrl("Designer2D.qml"),{nomObjet:"Designer 2D"});
                        }
                        width: parent.width
                        height: parent.height /3
                        color: "#8A9CFF"
                        Column {
                            Text {
                                id: libelleProjet
                                text: qsTr(libelle)
                            }
                            Text {
                                id:  dateProjet
                                text: qsTr(date)
                            }
                        }
                        ToolButton {
                            width: 50
                            height: 50
                            anchors.right: parent.right
                            icon.source: "../images/menu@2x.png"
                            Menu {
                                id: menu

                                MenuItem {
                                    text: "Editer Projet"
                                    onTriggered: {
                                        projetLibelleEdit.text = projetModel.get(flow.selected).libelle || ""
                                        editProjetDialog.visible = true
                                    }
                                }
                                MenuItem {
                                    text: "Clore Projet"
                                    onTriggered: {
                                        projetModel.remove(index)
                                    }
                                }
                            }
                            onClicked: {
                                flow.selected = index
                                menu.popup()
                            }
                        }

                    }
                    Rectangle {
                        id: base
                        width: 250
                        height: parent.height * 2/3
                        color: "#DDDDDD"
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
            projetLibelleAdd.text = ""
            projetCodeAdd.text =  ""
            addProjetDialog.visible = true
        }
    }

    Dialog {
        id: addProjetDialog
        visible: false
        title: "Ajouter projet"
        width: 350
        height: 250
        standardButtons: Dialog.Save | Dialog.Cancel
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        onAccepted: {
            projetModel.append({
                                   "libelle": projetLibelleAdd.text,
                                   "code": projetCodeAdd.text,
                                   "status" : "nouveau",
                                   "date" : "xx/xx/xx"
                               })
        }
        contentItem: ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            TextField {
                id: projetLibelleAdd
                font.pointSize: 15
                Layout.fillWidth: true
                placeholderText: qsTr("Libellé")
            }

            TextField {
                id: projetCodeAdd
                font.pointSize: 15
                Layout.fillWidth: true
                placeholderText: qsTr("Code")
            }

        }

    }

    Dialog {
        id: editProjetDialog
        visible: false
        title: "Editer projet"
        width: 350
        height: 200
        standardButtons: Dialog.Save | Dialog.Cancel
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        onAccepted: {
            projetModel.setProperty(flow.selected,"libelle", projetLibelleEdit.text)
        }
        contentItem: ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            TextField {
                id: projetLibelleEdit
                font.pointSize: 15
                Layout.fillWidth: true
                placeholderText: qsTr("Libellé")
            }

        }

    }



    ListModel {
        id: projetModel
        ListElement {
            libelle: "Maison 1"
            date: "25/06/2017"
        }

        ListElement {
            libelle: "Maison 2"
            date: "28/09/2017"
        }

        ListElement {
            libelle: "Maison 3"
            date: "28/11/2017"
        }
    }

    ListModel {
        id: clientsList
        ListElement {
            nom: "Diego"
        }

        ListElement {
            nom: "Pablo"
        }

        ListElement {
            nom: "Raoul"
        }
    }
}
