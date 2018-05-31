import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

ScrollView {
    z: -1

    ListView {
        z: -1
        model: moduleModel
        width: parent.width
        spacing: 5
        headerPositioning: ListView.OverlayHeader
        header:
            Rectangle {
                z: 2
                width: parent.width
                Layout.preferredHeight: parent.parent.height * 0.3
                height: stackView.parent.height / 10
                color: "#FAFAFA"
                RowLayout{
                z: 3
                anchors.fill: parent
                Item {
                    Layout.preferredWidth: parent.width * 0.05
                }
                Text {
                    Layout.preferredWidth: parent.width * 0.1
                    Layout.alignment: Qt.AlignLeft
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Nom"
                    font.bold: true
                }
                Text {
                    Layout.preferredWidth: parent.width * 0.1
                    Layout.alignment: Qt.AlignLeft
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Prix"
                    font.bold: true
                }
                Text {
                    Layout.preferredWidth: parent.width * 0.2
                    Layout.alignment: Qt.AlignLeft
                    anchors.verticalCenter: parent.verticalCenter
                    text: "gamme"
                    font.bold: true
                }
            }
            }
        delegate: Rectangle {
            Layout.preferredHeight: parent.parent.height * 0.3
            height: stackView.parent.height / 6
            width: parent.width
            MouseArea{
                height: parent.height
                width: parent.width
                onPressAndHold: {
                    moduleMenu.x = mouseX
                    moduleMenu.y = mouseY
                    moduleMenu.open()
                }
                RowLayout{
                    anchors.fill: parent
                    Item {
                        Layout.preferredWidth: parent.width * 0.05
                    }
                    Text {
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.alignment: Qt.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        text: nom
                    }
                    Text {
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.alignment: Qt.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        text: prix
                    }
                    Text {
                        Layout.preferredWidth: parent.width * 0.2
                        Layout.alignment: Qt.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        text: gamme
                    }
                }
                Menu {
                    id: moduleMenu
                    MenuItem {
                        text: "Editer module"
                        onTriggered: editModuleDialog.visible = true
                    }
                    MenuItem {
                        text: "Détails module"
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
        }
        Dialog {
            id: editModuleDialog
            visible: false
            title: "Editer module"
            width: 350
            height: 250
            standardButtons: Dialog.Save | Dialog.Cancel
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            contentItem: ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                TextField {
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Nom")
                }

                TextField {
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Gamme")
                }
            }

        }

        ListModel {
            id: moduleModel

            ListElement {
                nom: "Porte et Fenêtre Acajou"
                prix: "1800€"
                gamme:"Acajou"
            }

            ListElement {
                nom: "Porte et Fenêtre Acajou"
                prix: "1800€"
                gamme:"Acajou"
            }

            ListElement {
                nom: "Porte et Fenêtre Acajou"
                prix: "1800€"
                gamme:"Acajou"
            }

            ListElement {
                nom: "Porte et Fenêtre Acajou"
                prix: "1800€"
                gamme:"Acajou"
            }

            ListElement {
                nom: "Porte et Fenêtre Acajou"
                prix: "1800€"
                gamme:"Acajou"
            }

            ListElement {
                nom: "Porte et Fenêtre Acajou"
                prix: "1800€"
                gamme:"Acajou"
            }

            ListElement {
                nom: "Porte et Fenêtre Acajou"
                prix: "1800€"
                gamme:"Acajou"
            }

            ListElement {
                nom: "Porte et Fenêtre Acajou"
                prix: "1800€"
                gamme:"Acajou"
            }

            ListElement {
                nom: "Porte et Fenêtre Acajou"
                prix: "1800€"
                gamme:"Acajou"
            }
        }
    }
}
