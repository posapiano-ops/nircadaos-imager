/*
 * SPDX-License-Identifier: Apache-2.0
 * Copyright (C) 2020 Raspberry Pi (Trading) Limited
 */

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.2

Popup {
    id: msgpopup
    x: 75
    y: (parent.height-height)/2
    width: parent.width-150
    height: msgpopupbody.implicitHeight+150
    padding: 0
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    property alias title: msgpopupheader.text
    property alias text: msgpopupbody.text
    property bool continueButton: true
    property bool yesButton: false
    property bool noButton: false
    signal yes()
    signal no()

    // background of title
    Rectangle {
        color: "#f5f5f5"
        anchors.right: parent.right
        anchors.top: parent.top
        height: 35
        width: parent.width
    }
    // line under title
    Rectangle {
        color: "#afafaf"
        width: parent.width
        y: 35
        implicitHeight: 1
    }

    Text {
        id: msgx
        text: "X"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 25
        anchors.topMargin: 10
        font.family: roboto.name
        font.bold: true

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                msgpopup.close()
            }
        }
    }

    ColumnLayout {
        spacing: 20
        anchors.fill: parent

        Text {
            id: msgpopupheader
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.topMargin: 10
            font.family: roboto.name
            font.bold: true
        }

        Text {
            id: msgpopupbody
            font.pointSize: 12
            wrapMode: Text.Wrap
            textFormat: Text.StyledText
            font.family: roboto.name
            Layout.maximumWidth: msgpopup.width-50
            Layout.fillHeight: true
            Layout.leftMargin: 25
            Layout.topMargin: 25
            Accessible.name: text.replace(/<\/?[^>]+(>|$)/g, "")
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter | Qt.AlignBottom
            Layout.bottomMargin: 10
            spacing: 20

            Button {
                text: qsTr("NO")
                onClicked: {
                    msgpopup.close()
                    msgpopup.no()
                }
                Material.foreground: "#ffffff"
                Material.background: "#c51a4a"
                font.family: roboto.name
                visible: msgpopup.noButton
                Accessible.onPressAction: clicked()
            }

            Button {
                text: qsTr("YES")
                onClicked: {
                    msgpopup.close()
                    msgpopup.yes()
                }
                Material.foreground: "#ffffff"
                Material.background: "#c51a4a"
                font.family: roboto.name
                visible: msgpopup.yesButton
                Accessible.onPressAction: clicked()
            }

            Button {
                text: qsTr("CONTINUE")
                onClicked: {
                    msgpopup.close()
                }
                Material.foreground: "#ffffff"
                Material.background: "#c51a4a"
                font.family: roboto.name
                visible: msgpopup.continueButton
                Accessible.onPressAction: clicked()
            }

            Text { text: " " }
        }
    }

    function openPopup() {
        open()
        // trigger screen reader to speak out message
        msgpopupbody.forceActiveFocus()
    }
}