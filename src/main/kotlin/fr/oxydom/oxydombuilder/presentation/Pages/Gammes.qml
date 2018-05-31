import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtQuick.Controls.Styles 1.4

ScrollView {
    z: -1

    ListView {
        model: gammeModel
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
                    text: "Libellé"
                    font.bold: true
                }
                Text {
                    Layout.preferredWidth: parent.width * 0.1
                    Layout.alignment: Qt.AlignLeft
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Bonus Individuel"
                    font.bold: true
                }
                Text {
                    Layout.preferredWidth: parent.width * 0.1
                    Layout.alignment: Qt.AlignLeft
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Bonus de Gamme"
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
                    gammeMenu.x = mouseX
                    gammeMenu.y = mouseY
                    gammeMenu.open()
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
                        text: libelle
                    }
                    Text {
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.alignment: Qt.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        text: bonusIndividuel
                    }
                    Text {
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.alignment: Qt.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        text: bonusGamme
                    }
                }
                Menu {
                    id: gammeMenu
                    MenuItem {
                        text: "Editer gamme"
                        onTriggered: editGammeDialog.visible = true
                    }
                    MenuItem {
                        text: "Détails gamme"
                        onTriggered: detailsGammeDialog.visible = true
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
            id: editGammeDialog
            visible: false
            title: "Editer gamme"
            width: 350
            height: 300
            standardButtons: Dialog.Save | Dialog.Cancel
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            contentItem: ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                TextField {
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Libelle")
                }

                TextField {
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Bonus Individuel")
                }

                TextField {
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Bonus de Gamme")
                }

            }

        }

        Dialog {
            id: detailsGammeDialog
            visible: false
            title: "Détails gamme"
            width: 350
            height: 300
            standardButtons: Dialog.Save | Dialog.Cancel
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            contentItem: ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Label {
                    font.pointSize: 15
                    Layout.fillWidth: true
                    text: "Libelle"
                }

                Label {
                    font.pointSize: 15
                    Layout.fillWidth: true
                    text: "Bonus Individuel (%)"
                }

                Label {
                    font.pointSize: 15
                    Layout.fillWidth: true
                    text: "Bonus de Gamme (%)"
                }

            }

        }

        ListModel {
            id: gammeModel

            ListElement {
                libelle: "Acajou"
                bonusIndividuel: "5%"
                bonusGamme:"10%"
            }

            ListElement {
                libelle: "Acajou"
                bonusIndividuel: "5%"
                bonusGamme:"10%"
            }

            ListElement {
                libelle: "Acajou"
                bonusIndividuel: "5%"
                bonusGamme:"10%"
            }

            ListElement {
                libelle: "Acajou"
                bonusIndividuel: "5%"
                bonusGamme:"10%"
            }

            ListElement {
                libelle: "Acajou"
                bonusIndividuel: "5%"
                bonusGamme:"10%"
            }

            ListElement {
                libelle: "Acajou"
                bonusIndividuel: "5%"
                bonusGamme:"10%"
            }

            ListElement {
                libelle: "Acajou"
                bonusIndividuel: "5%"
                bonusGamme:"10%"
            }

            ListElement {
                libelle: "Acajou"
                bonusIndividuel: "5%"
                bonusGamme:"10%"
            }
        }
    }
}
