/***************************************************************************
* Copyright (c) 2013 Reza Fatahilah Shah <rshah0385@kireihana.com>
* Copyright (c) 2013 Abdurrahman AVCI <abdurrahmanavci@gmail.com>
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
* OR OTHER DEALINGS IN THE SOFTWARE.
*
***************************************************************************/

import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    width: 640
    height: 480
    color: "#8a979e"


    LayoutMirroring.enabled: Qt.locale().textDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property int sessionIndex: session.index

    TextConstants { id: textConstants }

    Connections {
        target: sddm
        onLoginSucceeded: {
        }
        onLoginFailed: {
            pw_entry.text = ""
        }
    }

    Background {

        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Error && source !== config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }

    Rectangle {
        id: rectangle1
        color: "#00000000"
        anchors.fill: parent

        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        Rectangle {
            id: rectangle
            x: 0
            y: 0
            width: 420; height: 400
            color: "#00000000"
            anchors.verticalCenterOffset: 20
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter


            Item {
                id: element_login_credentials
                width: 400
                height: 136
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 96
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 20

                    Text {
                        x: 120
                        y: 140
                        width: 233
                        height: 21
                        color: "#000000"
                        text:sddm.hostName
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.weight: Font.ExtraLight
                        opacity: 0.5

                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.horizontalCenterOffset: -56
                        anchors.horizontalCenter: parent.horizontalCenter

                        font.bold: true
                        font.pixelSize: 10
                    }
                    Column {
                        anchors.verticalCenterOffset: 12
                        anchors.horizontalCenterOffset: 0
                        anchors.centerIn: parent

                    Row {
                        id: row
                        width: 320
                        height: 30
                        Image { x: 0; y: 4; width: 42; height: 22; fillMode: Image.PreserveAspectFit; source: "user.svg" }

                        TextBox {
                            id: user_entry
                            x: 36
                            y: 4

                            width: 232; height: 24
                            radius: 3


                            textColor: "#404040"

                            font.pixelSize: 12

                            KeyNavigation.backtab: layoutBox; KeyNavigation.tab: pw_entry
                        }
                    }

                    Row {
                        id: row1
                        width: 320
                        height: 30

                        Image { y: 4; width: 42; height: 22; fillMode: Image.PreserveAspectFit; source: "password.svg" }

                        PasswordBox {
                            id: pw_entry
                            x: 36
                            y: 4
                            width: 232
                            height: 24
                            radius: 3
                            text: ""
                            textColor: "#404040"



                            tooltipBG: "CornflowerBlue"

                            font.pixelSize: 12

                            KeyNavigation.backtab: user_entry; KeyNavigation.tab: login_button

                            Keys.onPressed: {
                                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                    sddm.login(user_entry.text, pw_entry.text, sessionIndex)
                                    event.accepted = true
                                }
                            }
                        }
                    }
                }

                ImageButton {
                    id: login_button
                    x: 334
                    width: 48
                    height: 48
                    sourceSize.height: 0
                    sourceSize.width: 0
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenterOffset: 13
                    antialiasing: true
                    opacity: 1
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 26
                    visible: true


                    source: "log-in.svg"

                    onClicked: sddm.login(user_entry.text, pw_entry.text, sessionIndex)

                    KeyNavigation.backtab: pw_entry; KeyNavigation.tab: session_button
                }

                Image {
                    x: -9
                    y: -8
                    width: 384
                    height: 128
                    anchors.verticalCenterOffset: 0
                    anchors.horizontalCenterOffset: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: "overlay.png"
                    fillMode: Image.PreserveAspectFit
                    opacity: 0.1
                }


            }

            Item {
                id: element_action_buttons
                x: 0
                y: 378
                width: 400
                height: 50
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 24
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                antialiasing: true


                Flow {
                    id: button_flow
                    x: 83
                    width: if (sddm.canHibernate) 224
                           else 168
                    height: 49
                    anchors.horizontalCenter: parent.horizontalCenter

                    layoutDirection: Qt.LeftToRight

                    spacing: 0


                    Column  {
                        id:sys_button_grp
                        x: 0
                        width: 56
                        height: 49
                        clip: true
                        spacing: 3
                        ImageButton {
                            id: system_button
                            width: 40
                            height: 32
                            anchors.horizontalCenter: parent.horizontalCenter
                            antialiasing: true
                            opacity: 0.8
                            source: "shutdown.svg"
                            onClicked: sddm.powerOff()

                            KeyNavigation.backtab: session_button; KeyNavigation.tab: reboot_button
                            }
                        Text { x: 0; y: 30; width: 48; height: 14; color: "#404040";  text: "Shutdown"; anchors.horizontalCenter: parent.horizontalCenter; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 9 }
                    }

                    Column  {
                        id:reboot_button_grp
                        x: 0
                        width: 56
                        clip: true
                        spacing: 3
                        ImageButton {
                            id: reboot_button
                            x: 0
                            width: 40
                            height: 32
                            anchors.horizontalCenter: parent.horizontalCenter
                            opacity: 0.8
                            antialiasing: true
                            source: "reboot.svg"
                            onClicked: sddm.reboot()

                            KeyNavigation.backtab: system_button; KeyNavigation.tab: suspend_button
                            }
                         Text { x: 0; y: 30; width: 48; height: 14; color: "#404040";  text: "Reboot"; anchors.horizontalCenter: parent.horizontalCenter; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 9 }
                    }

                    Column  {
                        id:suspend_button_grp
                        x: 0
                        width: 56
                        clip: true
                        spacing: 3
                        ImageButton {
                            id: suspend_button
                            x: 0
                            width: 40
                            height: 32
                            anchors.horizontalCenter: parent.horizontalCenter
                            opacity: 0.8
                            antialiasing: true
                            source: "suspend.svg"
                            onClicked: sddm.suspend()

                            KeyNavigation.backtab: reboot_button; KeyNavigation.tab: hibernate_button
                            }
                        Text { x: 0; y: 30; width: 48; height: 14; color: "#404040";  text: "Suspend"; anchors.horizontalCenter: parent.horizontalCenter; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 9 }
                    }

                    Column  {
                        id:hibernate_button_grp
                        x: 0
                        width: 56
                        clip: true
                        spacing: 3
                        visible: sddm.canHibernate

                        ImageButton {
                            id: hibernate_button
                            x: 0
                            width: 40
                            height: 32
                            anchors.horizontalCenter: parent.horizontalCenter
                            opacity: 0.8
                            antialiasing: true
                            source: "hibernate.svg"
                            visible: sddm.canHibernate
                            onClicked: sddm.hibernate()

                            KeyNavigation.backtab: suspend_button; KeyNavigation.tab: session
                            }
                        Text {
                            x: 0; y: 30; width: 48; height: 14; color: "#404040";  text: "Hibernate"; anchors.horizontalCenter: parent.horizontalCenter; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 9
                            visible: sddm.canHibernate
                            }
                    }

                }


                Timer {
                    id: time
                    interval: 100
                    running: true
                    repeat: true

                    onTriggered: {
                        timeonly.text = Qt.formatTime(new Date(), "HH:mm AP")
                        dateonly.text = Qt.formatDate(new Date(), "dddd, dd MMMM yyyy")
                        }
                      }
            }

            Item {
                id:element_datetime
                x:170
                width: 300
                height: 108
                clip: false
                anchors.horizontalCenterOffset: 0
                anchors.top: parent.top
                anchors.topMargin: 4
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: timeonly
                    x: 16
                    y: 8
                    width: 276
                    height: 48
                    horizontalAlignment: Text.AlignHCenter

                    color: "#404040"
                    renderType: Text.NativeRendering
                    lineHeight: 0.8
                    font.family: config.TimeFont
                    font.weight: Font.Light
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 48
                }

                Text {
                    id: dateonly
                    x: 43
                    y: 68
                    width: 214
                    height: 30
                    horizontalAlignment: Text.AlignHCenter

                    color: "#404040"
                    font.family: config.DateFont
                    font.weight: Font.Light
                    anchors.horizontalCenterOffset: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: false
                    font.pixelSize: 24
                }


            }

        }
    }

    Rectangle {
        id: actionBar
        anchors.top: parent.top;
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width; height: 40
        color: "#5e636f"

        Row {
            anchors.margins: 5
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5

            Text {
                height: parent.height
                color: "#ffffff"
                anchors.verticalCenter: parent.verticalCenter

                text: textConstants.session
                font.weight: Font.Light
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
            }

            ComboBox {
                id: session
                width: 245
                height: 24
                anchors.verticalCenter: parent.verticalCenter

                arrowIcon: "drop-down.svg"

                model: sessionModel
                index: sessionModel.lastIndex
                font:font.pixelSize=12


                KeyNavigation.backtab: hibernate_button; KeyNavigation.tab: layoutBox
            }

            Text {
                height: parent.height
                color: "#ffffff"
                anchors.verticalCenter: parent.verticalCenter

                text: textConstants.layout
                font.weight: Font.Light
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
            }

            LayoutBox {
                id: layoutBox
                width: 90
                height: 24
                anchors.verticalCenter: parent.verticalCenter

                font: font.pixelSize =12

                arrowIcon: "drop-down.svg"

                KeyNavigation.backtab: session; KeyNavigation.tab: user_entry
            }
        }
    }

    Component.onCompleted: {
        if (user_entry.text === "")
            user_entry.focus = true
        else
            pw_entry.focus = true
    }
}















