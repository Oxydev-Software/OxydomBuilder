import QtQuick 2.0
    Rectangle {
        id: componentBase
        anchors.fill: parent
        anchors.margins: 0.07 * width
        property int widthBase: 500
        property int heightBase: 500
        border.color: "black"
        border.width: 5
        property var listMurs: []
        property var magnetObjet
        Component.onCompleted: {
            var scaleH = Math.round(dropZone.height / heightBase);
            var murs = JSON.parse('[{"type": "mur", "position": [120, 400], "width": 20, "height": 280, "rotation": 270, "slots": [{"x": 0, "y": 150, "width": 20, "height": 50, "typeSlot": "porte"}]}, {"type": "mur", "position": [400, 400], "width": 20, "height": 300, "rotation": 270, "slots": [{"x": 0, "y": 150, "width": 20, "height": 50, "typeSlot": "porte"}]}, {"type": "mur", "position": [700, 200], "width": 20, "height": 200, "rotation": 0, "slots": []}, {"type": "mur", "position": [720, 220], "width": 20, "height": 280, "rotation": -90, "slots": []}, {"type": "mur", "position": [100, 380], "width": 20, "height": 320, "rotation": 0, "slots": []}, {"type": "mur", "position": [120, 700], "width": 20, "height": 880, "rotation": 270, "slots": []}, {"type": "mur", "position": [1000, 200], "width": 20, "height": 500, "rotation": 0, "slots": []}]');
            for(var indexMur in murs) {
                var mur = murs[indexMur];
                var type = mur.type;
                var position = mur.position;
                var heightComponent = mur.height;
                var widthComponent = mur.width;
                var rotation = mur.rotation;
                var component;
                var sprite;
                component = Qt.createComponent("Designer2DMurs.qml");
                sprite = component.createObject(componentBase);
                sprite.x = position[0];
                sprite.y = position[1];
                sprite.width = widthComponent;
                sprite.height = heightComponent;
                sprite.type = "mur";
                for (var indexOther in listMurs) {
                    sprite.selected.connect(listMurs[indexOther].otherSelected);
                    listMurs[indexOther].selected.connect(sprite.otherSelected);
                }
                for(var indexSlot in mur.slots) {
                    var slot = mur.slots[indexSlot];
                    sprite.listModeleSlots.push(slot);
                }
                sprite.init();
                sprite.rotation = rotation;
                listMurs.push(sprite);
            }
            for(var indexMur in murs) {
                listMurs[indexMur].associerMurs(listMurs);
            }

        }
        DropArea {
            id: dropZone
            anchors.fill: componentBase
            signal clear()
            property var selectedItem
            onDropped: {
                var component;
                var sprite;
                var format = JSON.parse(drop.source.format);
                if (format.type === "mur") {
                    component = Qt.createComponent("Designer2DMurs.qml");
                    sprite = component.createObject(componentBase, {"x": drag.x, "y": drag.y, "width": format.width, "height": format.height, "type": format.type});
                    listMurs.push(sprite);
                    associer(sprite);

                } else {
                    component = Qt.createComponent("Designer2DComponent.qml");
                    sprite = component.createObject(componentBase, {"x": drag.x, "y": drag.y, "width": format.width, "height": format.height, "type": format.type});
                    associer(sprite);
                }

                drag.source.visible = false;
            }
            onPositionChanged: {
                var x = 999999999;
                var y = 999999999;
                console.log("Drag x: " + drag.source.x);
                console.log("Drag y: " + drag.source.y);
                var dragPoint = componentBase.mapFromItem(componentBase.parent.parent, drag.source.x, drag.source.y);
                console.log("Drag point x: " + dragPoint.x);
                console.log("Drag point y: " + dragPoint.y);
                for (var index in listMurs) {
                    var elt = listMurs[index];
                    var eltW = elt.getW();
                    var eltH = elt.getH();
                    var xElt;
                    var yElt;
                    if (elt.rotation === 90) {
                        xElt = elt.x - eltW / 2;
                        yElt = elt.y + eltH / 2;
                    } else if(elt.rotation === 0) {
                        xElt = elt.x + eltW / 2;
                        yElt = elt.y + eltH / 2;
                    } else if(elt.rotation === 180) {
                        xElt = elt.x - eltW / 2;
                        yElt = elt.y - eltH / 2;
                    } else if (elt.rotation === 270) {
                        xElt = elt.x + eltW / 2;
                        yElt = elt.y - eltH / 2;
                    }

                    console.log("enfant " + index + " delta : " + Math.sqrt(Math.pow(drag.source.x - xElt, 2) + Math.pow(drag.source.y - yElt, 2)) + ", y: " + elt.y)
                    if (Math.pow(dragPoint.x - xElt, 2) + Math.pow(dragPoint.y - yElt, 2) < x * x + y * y && elt.type === "mur") {
                        magnetObjet = elt;
                        x = dragPoint.x - xElt;
                        y = dragPoint.y - yElt;
                    }
                }
                if (magnetObjet !== selectedItem && selectedItem !== undefined) {
                    selectedItem.colorItem = "black";
                }
                if (magnetObjet !== undefined) {
                    magnetObjet.colorItem = "red";
                    selectedItem = magnetObjet
                    magnetObjet.redraw();
                }
            }

            function associer(objet) {
                if (magnetObjet !== undefined) {
                    if (magnetObjet.type === "mur") {
                        if (objet.type === "mur") {
                            magnetObjet.addMurVoisin(objet, true);
                            objet.addMurVoisin(magnetObjet, false);
                        } else {
                            magnetObjet.associer(objet);
                        }
                    }
                }
            }

        }
    }
