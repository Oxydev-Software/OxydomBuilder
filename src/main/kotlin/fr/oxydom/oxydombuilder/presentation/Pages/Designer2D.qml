import QtQuick 2.0

Item {
    id: rootItems
    anchors.top: toolbar.bottom
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    Rectangle {
        id: viewListItems
        anchors.top: parent.top
        anchors.left: parent.left
        width: 200
        anchors.bottom: parent.bottom

        Item {
            width: 200
            height: 300

            ListView {
                anchors.fill: parent
                model: nestedModel
                delegate: categoryDelegate
            }

            ListModel {
                id: nestedModel
                ListElement {
                    categoryName: "Fenetres"
                    collapsed: true

                    // A ListElement can't contain child elements, but it can contain
                    // a list of elements. A list of ListElements can be used as a model
                    // just like any other model type.
                    subItems: [
                        ListElement { itemName: "Fenetre acajou"; dragImage: "../images/fenetre.png"; formatItem: '{"type": "fenetre", "width": 64, "height": 64}'},
                        ListElement { itemName: "Fenetre ebene"; dragImage: "../images/fenetre.png"; formatItem: '{"type": "fenetre", "width": 64, "height": 32}' },
                        ListElement { itemName: "Fenetre des etoiles"; dragImage: "../images/fenetre.png"; formatItem: '{"type": "fenetre", "width": 32, "height": 32}'}
                    ]
                }

                ListElement {
                    categoryName: "Portes"
                    collapsed: true
                    subItems: [
                        ListElement { itemName: "Porte Acajou"; dragImage: "../images/porte.png"; formatItem: '{"type": "porte", "width": 32, "height": 32, "orientation": "NORTH"}'},
                        ListElement { itemName: "Porte Ebene"; dragImage: "../images/porte.png"; formatItem: '{"type": "porte", "width": 32, "height": 32}'},
                        ListElement { itemName: "Porte des Etoiles"; dragImage: "../images/porte.png"; formatItem: '{"type": "porte", "width": 32, "height": 32}'}
                    ]
                }

                ListElement {
                    categoryName: "Murs"
                    collapsed: true
                    subItems: [
                        ListElement { itemName: "Mur Acajou"; dragImage: "../images/porte.png"; formatItem: '{"type": "mur", "width": 20, "height": 120}'},
                        ListElement { itemName: "Mur Ebene"; dragImage: "../images/porte.png"; formatItem: '{"type": "mur", "width": 20, "height": 120}'},
                        ListElement { itemName: "Mur des Etoiles"; dragImage: "../images/porte.png"; formatItem: '{"type": "mur", "width": 20, "height": 120}'}
                    ]
                }
            }

            Component {
                id: categoryDelegate
                Column {
                    width: 200

                    Rectangle {
                        id: categoryItem
                        color: "white"
                        height: 50
                        width: 200

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            x: 15
                            font.pixelSize: 24
                            text: categoryName
                        }

                        Rectangle {
                            id: expand
                            width: 30
                            height: 30
                            anchors.right: parent.right
                            anchors.rightMargin: 15
                            anchors.verticalCenter: parent.verticalCenter
                            state: "RELEASED"
                            Image {
                                source: "../images/expand.png"
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectFit
                            }

                            MouseArea {
                                anchors.fill: parent
                                id: mousearea
                                // Toggle the 'collapsed' property
                                onClicked: {
                                    if (expand.state == "SELECTED") {
                                        expand.state = "RELEASED"
                                    } else {
                                        expand.state = "SELECTED"
                                    }

                                    nestedModel.setProperty(index, "collapsed", !collapsed)
                                }
                            }

                            states: [
                                    State {
                                        name: "SELECTED"
                                        PropertyChanges { target: expand; rotation: 0}
                                    },
                                    State {
                                        name: "RELEASED"
                                        PropertyChanges { target: expand; rotation: -90}
                                    }
                                ]

                                transitions: [
                                    Transition {
                                        from: "SELECTED"
                                        to: "RELEASED"
                                        reversible: false
                                        ColorAnimation { target: expand; duration: 100}
                                    },
                                    Transition {
                                        from: "RELEASED"
                                        to: "SELECTED"
                                        reversible: false
                                        ColorAnimation { target: expand; duration: 100}
                                    }
                                ]
                        }
                    }

                    Loader {
                        id: subItemLoader

                        // This is a workaround for a bug/feature in the Loader element. If sourceComponent is set to null
                        // the Loader element retains the same height it had when sourceComponent was set. Setting visible
                        // to false makes the parent Column treat it as if it's height was 0.
                        visible: !collapsed
                        property variant subItemModel : subItems
                        sourceComponent: collapsed ? null : subItemColumnDelegate
                        onStatusChanged: if (status == Loader.Ready) item.model = subItemModel
                    }
                }

            }

            Component {
                id: subItemColumnDelegate
                Column {
                    property alias model : subItemRepeater.model
                    width: 200
                    Repeater {
                        id: subItemRepeater
                        delegate: Rectangle {
                            height: 40
                            width: 200
                            id: itemText
                            MouseArea {
                                id: mouseareaText
                                anchors.fill: parent
                                drag.target: imageDragDrop
                                onReleased: imageDragDrop.Drag.drop()
                                onPressed: {
                                    imageDragDrop.source = dragImage
                                    imageDragDrop.parent = drawArea.parent
                                    imageDragDrop.x = mapToItem(rootItems, mouseX, mouseY).x
                                    imageDragDrop.y = mapToItem(rootItems, mouseX, mouseY).y
                                    imageDragDrop.visible = true
                                }
                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                x: 30
                                font.pixelSize: 18
                                text: itemName
                            }
                            Image {
                                id: imageDragDrop
                                source: null
                                visible: false
                                width: 64
                                height: 64
                                property string format: formatItem
                                Drag.active: mouseareaText.drag.active
                            }
                        }
                    }
                }
            }
        }
    }
    Rectangle {
        id: drawArea
        anchors.left: viewListItems.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Designer2DBase{ }
    }
}
