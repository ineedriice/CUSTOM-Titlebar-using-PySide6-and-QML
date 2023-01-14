import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Window

ApplicationWindow {
    property int bw: 5
    QtObject {
        id: internal
        function restoreFeature() {
            root.showNormal();
            restoredownBtn.visible = false;
            maximizeBtn.visible = true;
        }
        function maximizeFeature() {
            root.showMaximized();
            restoredownBtn.visible = true;
            maximizeBtn.visible = false;
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: {
            const p = Qt.point(mouseX, mouseY);
            const b = bw; // Increase the corner size slightly
            if (p.x < b || p.x >= width - b) return Qt.SizeHorCursor;
            if (p.y < b || p.y >= height - b) return Qt.SizeVerCursor;
        }
        acceptedButtons: Qt.NoButton // don't handle actual events
    }
    
    DragHandler {
        id: resizeHandler
        grabPermissions: TapHandler.TakeOverForbidden
        target: null
        onActiveChanged: if (active) {
            const p = resizeHandler.centroid.position;
            const b = bw + 10; // Increase the corner size slightly
            let e = 0;
            if (p.x < b) { e |= Qt.LeftEdge }
            if (p.x >= width - b) { e |= Qt.RightEdge }
            if (p.y < b) { e |= Qt.TopEdge }
            if (p.y >= height - b) { e |= Qt.BottomEdge }
            root.startSystemResize(e);
        }
    }

    id: root
    title: qsTr("Custom Titlebar")
    visible: true
    minimumHeight: 600 // Change this
    minimumWidth: 400 // and this as you wish :)
    flags: Qt.FramelessWindowHint | Qt.Window
    color: "#1d1d1d"
    Rectangle {
        id: titleBar
        width: parent.width
        height: 45
        color: "#2259c6"
        DragHandler {
            onActiveChanged: if (active) root.startSystemMove();
            target: null
        }

        Text {
            id: title
            text: qsTr("App Name")
            color: "white"
            font.pointSize: 18
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 26
            anchors.left: titleBar.left
        }
        Button {
            id: closeBtn
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 18
            anchors.topMargin: 20
            anchors.right: titleBar.right
            onClicked: Qt.quit()
            background: Rectangle {
                color: "transparent"
            }
            HoverHandler {
                acceptedDevices: PointerDevice.Mouse
                cursorShape: Qt.PointingHandCursor
            }
            Image {
                source: "./images/CloseBtn.png"
                width: parent.width
                height: parent.height
            }
        }

        Button {
            id: restoredownBtn
            width: 28
            height: 28
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 18
            anchors.topMargin: 20
            anchors.right: closeBtn.left
            visible: false
            onClicked: internal.restoreFeature()
            background: Rectangle {
                color: "transparent"
            }
            HoverHandler {
                acceptedDevices: PointerDevice.Mouse
                cursorShape: Qt.PointingHandCursor
            }
            Image {
                source: "./images/RestoreDownBtn.png"
                width: parent.width
                height: parent.height
            }
        }

        Button {
            id: maximizeBtn
            width: 28
            height: 28
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 18
            anchors.topMargin: 20
            anchors.right: closeBtn.left
            onClicked: internal.maximizeFeature()
            background: Rectangle {
                color: "transparent"
            }
            HoverHandler {
                acceptedDevices: PointerDevice.Mouse
                cursorShape: Qt.PointingHandCursor
            }
            Image {
                source: "./images/MaximizeBtn.png"
                width: parent.width
                height: parent.height
            }
        }

        Button {
            id: minimizeBtn
            width: 28
            height: 22
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 20
            anchors.topMargin: 20
            anchors.right: restoredownBtn.left
            onClicked: root.showMinimized();
            background: Rectangle {
                color: "transparent"
            }
            HoverHandler {
                acceptedDevices: PointerDevice.Mouse
                cursorShape: Qt.PointingHandCursor
            }
            Image {
                source: "./images/MinimizeBtn.png"
                width: parent.width
                height: parent.height
            }
        }
    }
}
