import QtQuick 2.0
    Rectangle {
        id: componentDraw
        property string type
        property bool isSelected: false
        property string colorItem: "black"
        property bool isModifiable
        signal fixed
        signal unfixed
        signal clear()
        signal selected()
        property var mursVoisins: []
        property var listModeleSlots: []
        property var listSlots: []
        transformOrigin: Item.TopLeft
        Canvas {
            id: ancreHaut
            width: 32
            height: 32
            x: componentDraw.width / 2 - width / 2
            y: -height
            onPaint: {
                if (isModifiable) {
                    var context = ancreHaut.getContext("2d");
                    context.beginPath();
                    context.strokeStyle = colorItem;
                    context.fillStyle = "blue"
                    context.lineWidth = 3;
                    context.moveTo(width / 2, height / 2)
                    context.arc(width / 2, height / 2, 16, 0, 2 * Math.PI);
                    context.fill();
                } else {
                    enabled = false;
                    visible = false;
                }
            }

            onYChanged: {
                parent.height -= y + 32
                parent.y += y + 32
                y = -32
            }

            MouseArea {
                id: mouseAncre
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.YAxis
            }
        }

        Canvas {
            id: canvas
            anchors.fill: parent
            anchors.centerIn: parent
            property bool toPaint: false
            onPaint: {
                var context = canvas.getContext("2d");
                context.beginPath();
                context.strokeStyle = colorItem;
                context.lineWidth = 3;
                context.rect(0, 0, parent.width, parent.height);
                context.stroke();
                for (var indexObjet in mursVoisins) {
                    var objet = mursVoisins[indexObjet];
                    var xw = parent.x - Math.round(Math.sin(parent.rotation * (Math.PI / 180))) * height + Math.round(Math.cos(parent.rotation * (Math.PI / 180))) * width;
                    var yh = parent.y + Math.round(Math.cos(parent.rotation * (Math.PI / 180))) * height + Math.round(Math.sin(parent.rotation * (Math.PI / 180))) * width;
                    var xwObjet = objet.x - Math.round(Math.sin(objet.rotation * (Math.PI / 180))) * objet.height + Math.round(Math.cos(objet.rotation * (Math.PI / 180))) * objet.width;
                    var yhObjet = objet.y + Math.round(Math.cos(objet.rotation * (Math.PI / 180))) * objet.height + Math.round(Math.sin(objet.rotation * (Math.PI / 180))) * objet.width;
                    var w = parent.width * Math.abs(Math.round(Math.cos(parent.rotation * Math.PI / 180))) + parent.height * Math.abs(Math.round(Math.sin(parent.rotation * Math.PI / 180)));
                    var h = parent.height * Math.abs(Math.round(Math.cos(parent.rotation * Math.PI / 180))) + parent.width * Math.abs(Math.round(Math.sin(parent.rotation * Math.PI / 180)));
                    var oW = objet.width * Math.abs(Math.round(Math.cos(objet.rotation * Math.PI / 180))) + objet.height * Math.abs(Math.round(Math.sin(objet.rotation * Math.PI / 180)));
                    var oH = objet.height * Math.abs(Math.round(Math.cos(objet.rotation * Math.PI / 180))) + objet.width * Math.abs(Math.round(Math.sin(objet.rotation * Math.PI / 180)));
                    if (Math.abs(Math.cos(parent.rotation)) === Math.abs(Math.cos(objet.rotation))) {
                        if (componentDraw.x === xwObjet || componentDraw.x === objet.x) {
                            context.clearRect(context.lineWidth, 0, parent.width - 2 * context.lineWidth, context.lineWidth);
                        } else if (xw === objet.x || xw === xwObjet) {
                            context.clearRect(context.lineWidth, parent.height - context.lineWidth, parent.width - 2 * context.lineWidth, context.lineWidth);
                        }
                        if (parent.y + (Math.sin(rotation * Math.PI / 180) * componentDraw.width + Math.cos(rotation * Math.PI / 180) * componentDraw.height) > objet.y + (Math.sin(rotation * Math.PI / 180) * objet.width + Math.cos(rotation * Math.PI / 180) * objet.height)) {
                            context.clearRect(context.lineWidth, 0, parent.width - 2 * context.lineWidth, context.lineWidth);
                        } else if(objet.y + (Math.sin(rotation * Math.PI / 180) * componentDraw.width + Math.cos(rotation * Math.PI / 180) * componentDraw.height) > parent.y + (Math.sin(rotation * Math.PI / 180) * objet.width + Math.cos(rotation * Math.PI / 180) * objet.height)) {
                            context.clearRect(parent.width - context.lineWidth, parent.height - context.lineWidth, parent.width - 2 * context.lineWidth, context.lineWidth);
                        }
                    } else {
                        if ((componentDraw.x === objet.x || componentDraw.x === xwObjet) && (componentDraw.y >= objet.y && yh <= yhObjet)) {
                            context.clearRect(context.lineWidth, 0, parent.width - 2 * context.lineWidth, context.lineWidth);
                        } else if((xw === objet.x || xw === xwObjet) && (componentDraw.y >= objet.y && componentDraw.y <= yhObjet)) {
                            context.clearRect(context.lineWidth, parent.height - context.lineWidth, parent.width - 2 * context.lineWidth, context.lineWidth);
                        } else if((componentDraw.x === objet.x || componentDraw.x === xwObjet) && (objet.y >= componentDraw.y && yhObjet <= componentDraw.y + componentDraw.height)) {
                            context.clearRect(0, objet.y - componentDraw.y + Math.sin((objet.rotation - componentDraw.rotation) * Math.PI / 180) * oH, context.lineWidth, oH - context.lineWidth);
                        } else if((xw === objet.x || xw === xwObjet) && (componentDraw.y <= objet.y && yh >= yhObjet)) {
                            context.clearRect(componentDraw.width - context.lineWidth, objet.y - componentDraw.y + Math.sin((objet.rotation - componentDraw.rotation) * Math.PI / 180) * oH, context.lineWidth, oH - context.lineWidth);
                        }
                    }
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!isSelected) {
                    selected();
                }
                if (isSelected) {
                    componentDraw.rotation += 90;
                } else {
                    colorItem = "yellow";
                    isSelected = true;
                }
            }
            drag.target: parent
            onReleased: parent.Drag.drop()
            onPressed: {
                if (drag.x !== undefined) {
                    parent.x = drag.x;
                    parent.y = mouseY;
                }
            }
        }


        Canvas {
            id: ancreBas
            width: 32
            height: 32
            x: componentDraw.width / 2 - width / 2
            y: componentDraw.height
            onPaint: {
                if (isModifiable) {
                    var context = ancreBas.getContext("2d");
                    context.beginPath();
                    context.strokeStyle = colorItem;
                    context.fillStyle = "blue"
                    context.lineWidth = 3;
                    context.moveTo(width / 2, height / 2)
                    context.arc(width / 2, height / 2, 16, 0, 2 * Math.PI);
                    context.fill();
                } else {
                    enabled = false;
                    visible = false;
                }
            }

            onYChanged: {
                parent.height += y - componentDraw.height
                parent.y = parent.y
            }

            MouseArea {
                id: mouseAncreBas
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.YAxis
            }
        }

        function otherSelected() {
            colorItem = "black";
            isSelected = false;
        }

        function associer(module) {
            var x = 999999999;
            var y = 999999999;
            var slotSelected;
            for(var indexSlot in listSlots) {
                var xSlot;
                var ySlot;
                var slot = listSlots[indexSlot];
                if (rotation === 90) {
                    xSlot = x - slot.y - slot.height / 2;
                    ySlot = y + slot.height / 2;
                } else if(rotation === 0) {
                    xSlot = x + slot.x + slot.width / 2;
                    ySlot = y + slot.y + slot.height / 2;
                } else if(rotation === 180) {
                    xSlot = x - slot.x - slot.width / 2;
                    ySlot = y - slot.y - slot.height / 2;
                } else if (rotation === 270) {
                    xSlot = x + slot.y + slot.height / 2;
                    ySlot = y - slot.x - slot.width / 2;
                }

                if(Math.pow(xSlot - (module.x + module.width / 2), 2) + Math.pow(ySlot - (module.y + module.height / 2), 2) < Math.pow(x, 2) + Math.pow(y, 2) && slot.typeSlot === module.type) {
                    x = xSlot - (module.x + module.width / 2);
                    y = ySlot - (module.y + module.height / 2);
                    slotSelected = slot;
                }
            }
            if (slotSelected !== undefined) {
                return slotSelected.accepter(module);
            }
            return false;
        }

        function addChildren(objet) {
            if (objet.rotation === 0 && rotation === 0) {
                if (objet.y + objet.height / 2 < y + height / 2) {
                    objet.parent = componentDraw;
                    objet.x = 0;
                    objet.y = -objet.height;
                }
            }
            if (objet.rotation === 90 && rotation === 0) {
                if (objet.y + objet.height / 2 < y + height / 2) {
                    objet.parent = componentDraw;
                    objet.x = 0;
                    objet.y = 0;
                }
            }
        }

        onIsSelectedChanged: {
            canvas.requestPaint();
        }

        onFixed: {
            colorItem = "black";
            canvas.requestPaint();
        }

        onUnfixed: {
            colorItem = "red";
            canvas.requestPaint();
        }

        onColorItemChanged: {
            canvas.requestPaint();
        }

        onRotationChanged: {
            /*var tmp = componentDraw.width;
            var tmpX = componentDraw.x;
            var tmpY = componentDraw.y;
            componentDraw.width = componentDraw.height;
            componentDraw.height = tmp;
            console.log("x: " + x);
            console.log("y : " + y);
            console.log("w: " + width);
            //componentDraw.rot.angle = rotationItem;*/
            console.log("x: " + x);
            console.log("y : " + y);
            console.log("w: " + width);
            //componentDraw.x = tmpX*Math.cos(rotation * Math.PI / 180) + tmpY * Math.sin(rotation * Math.PI / 180);
            //componentDraw.y = -tmpX * Math.sin(rotation * Math.PI / 180) + tmpY * Math.cos(rotation * Math.PI / 180);
            //canvas.requestPaint();
            /*for (var indexSlot in listModeleSlots) {
                var slot = listSlots[indexSlot];
                var tmpX = slot.x * Math.cos(rotationItem * Math.PI / 180) + slot.y * Math.sin(rotationItem * Math.PI / 180);
                var tmpY = slot.x * Math.sin(rotationItem * Math.PI / 180) + slot.y * Math.cos(rotationItem * Math.PI / 180);
                var tmpDim = slot.width;
                slot.x = tmpX;
                slot.y = tmpY;
                slot.width = slot.height;
                slot.height = tmpDim;
            }*/
            canvas.requestPaint();
        }

        function associerMurs(listMurs) {
            for(var indexMur in listMurs) {
                var objet = listMurs[indexMur];
                if (objet !== this) {
                    /*if ((Math.abs(Math.cos(rotationItem)) - Math.abs(Math.cos(objet.rotationItem))) === 0) {
                        if((x + height === objet.x || x === objet.x + objet.height)  && objet.y === y && Math.cos(rotationItem) === 0) {
                            mursVoisins.push(objet);
                        } else if((y + height === objet.y || y === objet.y + objet.height) && objet.x === x && Math.sin(rotationItem) === 0) {
                            mursVoisins.push(objet);
                        }
                    } else {
                        if ((objet.x + objet.height === x || x + width === objet.x) && Math.abs(objet.y + objet.width / 2 - (y + height / 2)) <= (Math.abs(height / 2 - objet.width / 2))) {
                            mursVoisins.push(objet);

                        } else if((y + width === objet.y || objet.y + objet.height === y) && Math.abs(objet.x + objet.width / 2 - (x + height / 2)) <= (Math.abs(height / 2 - objet.width / 2))) {
                            mursVoisins.pus(objet);
                        }
                    }*/

                    if (this !== objet) {
                        var xw = x - Math.round(Math.sin(rotation * (Math.PI / 180))) * height + Math.round(Math.cos(rotation * (Math.PI / 180))) * width;
                        var yh = y + Math.round(Math.cos(rotation * (Math.PI / 180))) * height + Math.round(Math.sin(rotation * (Math.PI / 180))) * width;
                        var xwObjet = objet.x - Math.round(Math.sin(objet.rotation * (Math.PI / 180))) * objet.height + Math.round(Math.cos(objet.rotation * (Math.PI / 180))) * objet.width;
                        var yhObjet = objet.y + Math.round(Math.cos(objet.rotation * (Math.PI / 180))) * objet.height + Math.round(Math.sin(objet.rotation * (Math.PI / 180))) * objet.width;
                        if (Math.abs(Math.cos(rotation)) === Math.abs(Math.cos(objet.rotation))) {
                            if (((x === xwObjet || xw === objet.x) && (y === objet.y)) || (y === yhObjet || yh === objet.y && (x === objet.x))) {
                                mursVoisins.push(objet);
                            }
                        } else {
                            if((objet.x === x || objet.x === xw || x === xwObjet || xw === xwObjet) && ((objet.y >= y && yhObjet <= yh) || (y >= objet.y && yh <= yhObjet))) {
                                mursVoisins.push(objet);
                            }
                        }
                    }
                }
            }
            canvas.requestPaint();
        }

        function addMurVoisin(objet, resize) {
            if (resize) {
                if (rotation === 0) {
                    if (objet.x >= x + width) {
                        objet.x = componentDraw.x + width;
                        objet.rotation = 270;
                    } else if (objet.x <= x) {
                        objet.parent = this;
                        objet.x = 0;
                        objet.rotation = 90;
                    }
                } else if (rotation === 270) {
                    if (objet.y + objet.height <= y + width) {
                        objet.y = componentDraw.y - componentDraw.width - objet.height;
                    } else if (objet.y >= y) {
                        objet.y = componentDraw.y;
                    }
                } else if (rotation === 90) {
                    if(objet.y + objet.height <= y) {
                        objet.y = componentDraw.y - objet.height;
                    } else if (objet.y >= y + width) {
                        objet.y = y + width;
                    }
                }
            }
            mursVoisins.push(objet);
            canvas.requestPaint();
        }

        function redraw() {
            canvas.requestPaint();
        }

        function init() {
            for (var indexSlot in listModeleSlots) {
                var slot = listModeleSlots[indexSlot];
                var component = Qt.createComponent("Designer2DSlot.qml");
                var sprite = component.createObject(componentDraw, {"x": slot.x, "y": slot.y, "width": slot.width, "height": slot.height, "typeSlot": slot.typeSlot});
                listSlots.push(sprite);
            }
        }

        function getW() {
            return width * Math.abs(Math.round(Math.cos(rotation * Math.PI / 180))) + height * Math.abs(Math.round(Math.sin(rotation * Math.PI / 180)));
        }

        function getH() {
            return height * Math.abs(Math.round(Math.cos(rotation * Math.PI / 180))) + width * Math.abs(Math.round(Math.sin(rotation * Math.PI / 180)));
        }
    }
