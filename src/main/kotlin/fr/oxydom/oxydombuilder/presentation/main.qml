import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Pages"
import io.qt.examples.backend 1.0


ApplicationWindow {
    id: mainWindow
    visible: true
    //visibility: "Maximized"
    width: 1280
    height: 800
    color: "#fafafa"
    title: qsTr("Oxydom Builder")

    ToolBar {
        id: toolbar
        visible: false
        width: parent.width
        z: 1
        BackEnd {
            id: backend
        }
        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                id: leftToolbarButton
                icon.source: {
                    if (stackView.depth < 3) {
                        return "../images/invisible.png"
                    } else {
                        return "../images/back.png"
                    }
                }
                onClicked: {
                    if (stackView.depth > 2) {
                        stackView.pop()
                    }
                }
            }

            Label {
                id: titleLabel
                // text: stackView.currentItem ? stackView.currentItem.nomObjet : ""
                font.pixelSize: 20
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                icon.source: "../images/loupe.png"
                onClicked: searchMenu.open()

                Menu {
                    id: searchMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "Search"
                        onTriggered: settingsDialog.open()
                    }
                }
            }

            ToolButton {
                icon.source: "../images/menu.png"
                onClicked: optionsMenu.open()

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "Gammes"
                        onTriggered: {stackView.push(Qt.resolvedUrl("Pages/Gammes.qml"),{nomObjet: "Gammes"});}
                    }
                    MenuItem {
                        text: "Modules"
                        onTriggered: {stackView.push(Qt.resolvedUrl("Pages/Modules.qml"),{nomObjet: "Modules"});}
                    }
                    MenuItem {
                        text: "Modeles"
                        onTriggered: {stackView.push(Qt.resolvedUrl("Pages/Modeles.qml"),{nomObjet: "Modeles"});}
                    }
                    MenuItem {
                        text: "Deconnexion"
                        onTriggered: {
                            stackView.clear()
                            toolbar.visible = false
                            stackView.push(Qt.resolvedUrl("Pages/Login.qml"),{nomObjet: "Login"});
                        }
                    }
                }
            }
        }
    }

    StackView {
        id: stackView
        anchors.top: toolbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        focus: true
        initialItem: Item {
            width: mainWindow.width
            height: mainWindow.height
            Login{}
        }
    }
}
