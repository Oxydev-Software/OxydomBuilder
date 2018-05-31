import QtQuick 2.0

Rectangle {
    id: slot
    property string typeSlot
    Canvas {
        id: canvasSlot
        anchors.fill: parent
        onPaint: {
            var context = canvasSlot.getContext("2d");
            context.beginPath();
            context.strokeStyle = "blue";
            context.lineWidth = 3;
            context.rect(0, 0, slot.width, slot.height);
            context.stroke();
        }
    }

    function accepter(objet) {
        if (objet.type === typeSlot) {
            var xw = parent.x - Math.round(Math.sin(parent.rotation * (Math.PI / 180))) * parent.height + Math.round(Math.cos(parent.rotation * (Math.PI / 180))) * parent.width;
            var yh = parent.y + Math.round(Math.cos(parent.rotation * (Math.PI / 180))) * parent.height + Math.round(Math.sin(parent.rotation * (Math.PI / 180))) * parent.width;
            if ((objet.y >= yh && parent.rotation === 90) || (objet.y + objet.height <= yh && parent.rotation === 270)) {
                objet.parent = parent;
                objet.x = x + width;
                objet.y = y;
                objet.rotation = parent.rotation + 90;
            } else if ((objet.y + objet.height <= parent.y && parent.rotation === 90) || (objet.y >= parent.y + parent.height && parent.rotation === 270)) {
                objet.parent = parent;
                objet.rotation = parent.rotation + 90;
                objet.x = x - objet.width;
                objet.y = y;
            }
            canvasSlot.opacity = 0;
            slot.opacity = 0;
            objet.repaint();
        }
        return false;
    }
}
