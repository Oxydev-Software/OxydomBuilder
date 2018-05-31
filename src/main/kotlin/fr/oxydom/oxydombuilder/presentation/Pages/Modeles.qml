import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

ScrollView {
    z: -1

    ListView {
        z: -1
        model: modeleModel
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
                    Layout.preferredWidth: parent.width * 0.1
                    Layout.alignment: Qt.AlignLeft
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Gamme"
                    font.bold: true
                }
                Text {
                    Layout.preferredWidth: parent.width * 0.1
                    Layout.alignment: Qt.AlignLeft
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Dimension (HxL)"
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
                    modeleMenu.x = mouseX
                    modeleMenu.y = mouseY
                    modeleMenu.open()
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
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.alignment: Qt.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        text: gamme
                    }
                    Text {
                        Layout.preferredWidth: parent.width * 0.1
                        Layout.alignment: Qt.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        text: dimension
                    }
                }
                Menu {
                    id: modeleMenu
                    MenuItem {
                        text: "Editer modele"
                        onTriggered: editModeleDialog.visible = true
                    }
                    MenuItem {
                        text: "Détails modele"
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
            id: editModeleDialog
            visible: false
            title: "Editer modele"
            width: 350
            height: 400
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
                    placeholderText: qsTr("Prix")
                }

                TextField {
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Gamme")
                }

                TextField {
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Dimension H")
                }

                TextField {
                    font.pointSize: 15
                    Layout.fillWidth: true
                    placeholderText: qsTr("Dimension L")
                }

            }

        }

        ListModel {
            id: modeleModel

            ListElement {
                nom: "Porte Acajou"
                prix: "1200€"
                gamme:"Acajou"
                dimension: "200x60"
            }

            ListElement {
                nom: "Porte Acajou"
                prix: "1200€"
                gamme:"Acajou"
                dimension: "200x60"
            }

            ListElement {
                nom: "Porte Acajou"
                prix: "1200€"
                gamme:"Acajou"
                dimension: "200x60"
            }

            ListElement {
                nom: "Porte Acajou"
                prix: "1200€"
                gamme:"Acajou"
                dimension: "200x60"
            }

            ListElement {
                nom: "Porte Acajou"
                prix: "1200€"
                gamme:"Acajou"
                dimension: "200x60"
            }

            ListElement {
                nom: "Porte Acajou"
                prix: "1200€"
                gamme:"Acajou"
                dimension: "200x60"
            }

            ListElement {
                nom: "Porte Acajou"
                prix: "1200€"
                gamme:"Acajou"
                dimension: "200x60"
            }
        }
    }
}
