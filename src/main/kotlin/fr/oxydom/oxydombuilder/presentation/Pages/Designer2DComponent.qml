import QtQuick 2.0
    Rectangle {
        id: componentDraw
        property string type
        property bool isSelected: false
        property string colorItem: "black"
        property int rotationItem: 0
        property bool isModifiable
        signal fixed
        signal unfixed
        signal clear()
        signal selected()
        transformOrigin: Item.Center

        Canvas {
            id: canvas
            anchors.fill: parent
            anchors.centerIn: parent
            property bool toPaint: false
            onPaint: {
                var context = canvas.getContext("2d");
                context.beginPath();
                context.strokeStyle = colorItem;
                context.lineWidth = 1;
                if (type == "porte") {
                    var x = componentDraw.width;
                    var y = componentDraw.height;
                    var radius = width - context.lineWidth;
                    var startangle = 90 + rotationItem;
                    var endangle = rotationItem;
                    context.moveTo(context.lineWidth, context.lineWidth);
                    context.lineTo(context.lineWidth, componentDraw.height - context.lineWidth);
                    context.lineTo(componentDraw.width - context.lineWidth, componentDraw.height - context.lineWidth);
                    context.arc(context.lineWidth, componentDraw.height - context.lineWidth, radius, (startangle)*(Math.PI/180), (endangle)*(Math.PI/180)) //x, y, radius, startAngle, endAngle, anticlockwise
                } else if(type == "mur") {
                    var w = Math.abs(width * Math.cos(Math.PI * rotation / 180) + height * Math.sin(Math.PI * rotation / 180));
                    var h = Math.abs(height * Math.sin(Math.PI * rotation / 180) + height * Math.cos(Math.PI * rotationItem / 180));
                    //context.rect(0, 0, w, h);
                    if (componentDraw.parent.type === "mur") {
                        if (rotationItem === 90) {
                            if (componentDraw.parent.rotationItem === 0) {
                                if (componentDraw.y <= 0) {
                                    context.moveTo(0, height);
                                    context.lineTo(0, 0);
                                    context.lineTo(width, 0);
                                    context.lineTo(width, height);
                                    context.lineTo(componentDraw.parent.width, height)
                                }
                            }
                         }
                    } else {
                        context.rect(0, 0, w, h);
                    }

                } else if(type == "fenetre") {
                    var xw = (width / 2) * Math.cos(30 * (Math.PI / 180));
                    var xh =  -(width / 2) * Math.sin(30 * (Math.PI / 180));
                    context.moveTo(0, height);
                    context.lineTo(xw, height + xh);
                    context.moveTo(width, height);
                    context.lineTo(width - xw, height + xh);
                    if (orientation == "OUEST") {
                        parent.rotation = 270
                    } else if (orientation == "EST") {
                        parent.rotation = 90
                    }
                }
                context.stroke();
                //context.closePath();

            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!isSelected) {
                    selected();
                }
                if (isSelected) {
                    rotationItem += 90;
                } else {
                    colorItem = "yellow";
                    isSelected = true;                    
                }
            }
            drag.target: parent
            onReleased: parent.Drag.drop()
            onPressed: {
                if (drag) {
                    parent.x = drag.x;
                    parent.y = mouseY;
                }
            }
        }

        function otherSelected() {
            colorItem = "black";
            isSelected = false;
        }

        function associer(childrenElt) {
            if (type == "mur" && childrenElt.type == "mur") {
                if (orientation == "NORD" || orientation == "SOUTH") {
                    if (childrenElt.orientation == "NORD" && childrenElt.y + childrenElt.height / 2 > x + height / 2) {
                        childrenElt.parent = this;
                        childrenElt.x = 0;
                        childrenElt.y = -childrenElt.height;
                    }
                }
            }
        }

        function addChildren(objet) {
            if (objet.rotationItem === 0 && rotationItem === 0) {
                if (objet.y + objet.height / 2 < y + height / 2) {
                    objet.parent = componentDraw;
                    objet.x = 0;
                    objet.y = -objet.height;
                }
            }
            if (objet.rotationItem === 90 && rotationItem === 0) {
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

        function repaint() {
            canvas.requestPaint();
        }
    }
