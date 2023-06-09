import QtQuick
import QtQuick.Controls
import QtQuick.Window

import LazyTools

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Row {
        Button {
            text: "load"
            onClicked: {
                loader.sourceComponent = comp
            }
        }
        Button {
            text: "unload"
            onClicked: {
                loader.sourceComponent = undefined
            }
        }
    }

    Loader {
        id: loader
        y: 50
    }

    Component {
        id: comp

        Rectangle {
            id: rec
            color: "red"
            width: 100
            height: 100

            property var debounce:  LazyTools.debounce(rec, function () {
                                        console.log("debounce call")
                                    }, 1000, {})

            Component.onCompleted: {
//                let debounce =  LazyTools.debounce(rec, function () {
//                    console.log("debounce call")
//                }, 1000, {})
            }

            Component.onDestruction: {
                console.log("Component.onDestruction")
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    debounce.call()
//                    LazyTools.delay(1000, function () {console.log("delay call")})
                }
            }
        }
    }

}
