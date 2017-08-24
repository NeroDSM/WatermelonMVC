import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.3

Window {
    visible: true
    minimumWidth: 800
    minimumHeight: 600
    width: 800
    height: 600
    id: mainWin
    title: qsTr("Арбузная математика")

    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        Rectangle {
            id: firstblock
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

            ListView {
                id: answer
                interactive: false
                orientation: ListView.Horizontal
                model: WMModel

                delegate: Rectangle {
                    width: mainWin.width
                    height: 50

                    Text {
                        font.pointSize: 18
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        id: answertext
                        text: qsTr("Вес после усыхания: %1 кг.").arg(model.answer.toFixed(2))
                    }
                }
            }
        }

        Rectangle {
            id: secondblock
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter

            RowLayout {
                spacing: 0
                anchors.fill: parent

                Rectangle {
                    Layout.preferredWidth: 40
                    Layout.fillHeight: true
                }

                Rectangle {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.preferredHeight: mainWin.height * 0.8
                    Layout.preferredWidth: 120

                    ListView {
                        id: initweight
                        model: WMModel
                        interactive: false

                        delegate: Rectangle {
                            height: secondblock.height

                            Text {
                                font.pointSize: 12
                                id: slider1txt
                                width: 120
                                horizontalAlignment: Text.AlignJustify
                                text: qsTr("Начальный вес\nарбуза: %1 кг.").arg(model.initweight)
                            }

                            Slider {
                                id: slider1
                                height: wm_empty.height * 0.8
                                anchors.top: slider1txt.bottom
                                anchors.topMargin: 20
                                anchors.horizontalCenter: slider1txt.horizontalCenter
                                minimumValue: 5
                                maximumValue: 15
                                onValueChanged: model.initweight = slider1.value.toFixed(2)
                                orientation: Qt.Vertical
                                style: SliderStyle {
                                    handle: Image {
                                        source: "qrc:/img/wm.png"
                                        width: 64
                                        height: 64
                                        rotation: 90
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: imagebase
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter:  parent.horizontalCenter
                        width: Math.min(parent.height, parent.width)
                        height: width
                        id: wm_empty
                        source: "qrc:/img/wm_empty.png"
                        fillMode: Image.PreserveAspectFit
                        horizontalAlignment: Image.AlignHCenter
                    }

                    ListView {
                        id: scaleimage
                        model: WMModel
                        interactive: false

                        delegate: Rectangle {
                            height: imagebase.height
                            width: imagebase.width
                            color: "transparent"

                            Image {
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter:  parent.horizontalCenter
                                width: wm_empty.width * model.initwater / 100
                                height: width
                                id: wm_full
                                source: "qrc:/img/wm_full.png"
                                fillMode: Image.PreserveAspectFit
                                horizontalAlignment: Image.AlignHCenter
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 120
                    Layout.fillHeight: true
                }
            }
        }

        Rectangle {
            id: thirdblock
            Layout.fillWidth: true
            Layout.preferredHeight: 80

            ListView {
                id: initwater
                model: WMModel
                interactive: false

                delegate: Rectangle {
                    width: thirdblock.width
                    height: thirdblock.height

                    Text {
                        id: slider2txt
                        font.pointSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        anchors.fill: parent
                        text: qsTr("Процент воды после усыхания: %1 %").arg(model.initwater)
                    }

                    Slider {
                        id: slider2
                        anchors.fill: parent
                        anchors.leftMargin: 200
                        anchors.rightMargin: 140
                        anchors.topMargin: 20
                        minimumValue: 50
                        maximumValue: 99
                        onValueChanged: model.initwater = slider2.value.toFixed(0)
                        style: SliderStyle {
                            handle: Image {
                                source: "qrc:/img/wm.png"
                                width: 64
                                height: 64
                            }
                        }
                    }
                }
            }
        }
    }
}
