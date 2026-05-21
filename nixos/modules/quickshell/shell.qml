//@ pragma UseQApplication
import "MyText.qml"
import QtQuick
import QtQuick.Controls
import QtQuick // for Text
import Quickshell // for PanelWindow
import Quickshell.I3 
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray 

PanelWindow {
    id: window

    property int height: 30
    property int standardPadding: 15
    property int workspaceNumber: 5
    property int padding_: 10
    
    color: "transparent"

    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        top: 10
        left: 50
        right: 50
    }

    implicitHeight: height

    // The module template that is used for every bar widget 
    component Module: Column {
        property color underlineColor
        default property alias content: row_id.data

        topPadding: 5

        // The actual content
        Row {
            id: row_id

            leftPadding: padding_
            rightPadding: padding_
        }

        // The colored underline
        Rectangle {
            width: row_id.width
            height: 3
            color: underlineColor
        }
    }
        
    // --- BAR ---
    Rectangle {
        anchors.fill: parent
        radius: 10

        color: Colorscheme.background

        // --- LEFT SIDE ---
        Row {
            leftPadding: standardPadding
            anchors.rightMargin: standardPadding
            anchors.verticalCenter: parent.verticalCenter

            // --- Workspaces ---
            Module {
                underlineColor: Colorscheme.workspaceColor
                id: workspaceModule

                Repeater {
                    // I don't like the number of desktops being dynamic so here I fix it
                    // at 5
                    model: workspaceNumber

                    delegate: Button {
                        property int name: modelData + 1

                        // Returns wheter or not we are in an already existing workspace
                        // or not
                        function is_real() {
                            for (const workspace of I3.workspaces.values) {
                                if (workspace.name == name)
                                    return workspace
                            }

                            return false
                        }

                        // Returns the correct symbol given the current workspace
                        function get_symbol() {
                            let workspace = is_real()

                            if (!workspace) return ""
                            if (workspace.active) return ""
                            
                            return ""
                        }

                        width: 22
                        height: 22

                        background: Rectangle {
                            color: "transparent"
                        }

                        contentItem: MyText {
                            text: get_symbol()
                            color: Colorscheme.foreground
                            font.pixelSize: 14
                        }

                        // Center the workspaces
                        y: -3

                        onClicked: () => I3.dispatch(`workspace ${name}`)
                    }
                }
            }

            // --- Days since february 24th ---
            Module {
                underlineColor: Colorscheme.februaryColor
                id: februaryModule

                property var startDate: new Date("2025-02-24")

                function get_days_since() {
                    let now = new Date()
                    let diffMs = now - startDate
                    return Math.floor(diffMs / (1000 * 60 * 60 * 24))
                }

                property int daysSince: get_days_since()

                MyText {
                    text: ""
                    rightPadding: padding_
                    color: Colorscheme.februaryColor
                }

                Timer {
                    interval: 60 * 1000

                    running: true
                    repeat: true

                    onTriggered: {
                        februaryModule.daysSince = get_days_since()
                    }
                }

                MyText {
                    text: `${februaryModule.daysSince} days`
                    color: Colorscheme.foreground
                }
            }

            // --- System Tray ---
            Module {
                id: trayModule
                underlineColor: Colorscheme.trayColor

                Row {
                    spacing: 5
                    
                    Repeater {
                        model: SystemTray.items.values

                        Item {
                            width: 20
                            height: 22
                            
                            Image {
                                width: 20
                                height: 20
                                source: modelData.icon
                                anchors.top: parent.top

                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                                    onClicked: (mouse) => {
                                        if (mouse.button === Qt.RightButton) {
                                            let position = mapToGlobal(mouse.x, mouse.y)
                                            modelData.display(window, position.x, position.y)
                                        } else if (mouse.button == Qt.LeftButton) {
                                            modelData.activate()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        // --- RIGHT SIDE ---
        Row {
            anchors.right: parent.right
            anchors.rightMargin: standardPadding
            anchors.verticalCenter: parent.verticalCenter

            // --- Volume ---
            Module {
                underlineColor: Colorscheme.volumeColor
                id: volumeModule

                // Needed for this to work
                PwObjectTracker {
                    objects: [ Pipewire.defaultAudioSink ]
                }

                property real currentVolume: Pipewire.defaultAudioSink?.audio?.volume ?? 0
                property bool isMuted: Pipewire.defaultAudioSink?.audio?.muted ?? false

                function setVolume(volume) {
                    Pipewire.defaultAudioSink.audio.volume = Math.max(0, Math.min(1., volume))
                }

                MyText {
                    text: (volumeModule.isMuted) ? "" : ""
                    rightPadding: padding_
                    color: Colorscheme.volumeColor
                }

                Slider {
                    from: 0
                    to: 1
                    rightPadding: 4
                    implicitHeight: window.height - 10
                    id: volumeSlider

                    value: volumeModule.currentVolume

                    handle: Item {}

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.NoButton
                        onWheel: (wheel) => {
                            let step = 0.05
                            let delta = wheel.angleDelta.y > 0 ? step : -step
                            volumeModule.setVolume(volumeModule.currentVolume + delta)
                        }
                    }

                    onMoved: {
                        volumeModule.setVolume(value)
                    }

                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 6
                        x: volumeSlider.leftPadding
                        y: volumeSlider.topPadding + (volumeSlider.availableHeight - height) / 2
                        width: volumeSlider.availableWidth
                        height: implicitHeight
                        radius: 10
                        color: Colorscheme.volumeDarkColor

                        Rectangle {
                            width: volumeSlider.visualPosition * parent.width
                            height: parent.height
                            color: Colorscheme.volumeColor
                            bottomLeftRadius: 10
                            topLeftRadius: 10
                        }
                    }
                }
            }

            // --- Resources ---
            Module {
                underlineColor: Colorscheme.resourcesColor
                id: resourcesModule

                property int memoryPercentage: 0
                property int cpuPercentage: 0
                property int temperature: 0

                MyText {
                    text: ""
                    rightPadding: padding_
                    color: Colorscheme.resourcesColor
                }

                MyText {
                    text: `${resourcesModule.memoryPercentage}%`
                    rightPadding: padding_
                }

                MyText {
                    text: "󰍛"
                    rightPadding: padding_
                    color: Colorscheme.resourcesColor
                }

                MyText {
                    rightPadding: padding_
                    text: `${resourcesModule.cpuPercentage}%`
                }

                MyText {
                    text: ""
                    rightPadding: padding_
                    color: Colorscheme.resourcesColor
                }

                MyText {
                    text: `${resourcesModule.temperature}°`
                }

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: {
                        memoryProcess.running = true
                        cpuProcess.running = true
                        temperatureProcess.running = true
                    }
                }

                Process {
                    id: memoryProcess
                    running: true
                    command: [ "sh", "-c", "free | grep Mem | awk '{print $3/$2 * 100.}'" ]
                    stdout: StdioCollector {
                        onStreamFinished: {
                            resourcesModule.memoryPercentage = this.text
                        }
                    }
                }

                Process {
                    id: cpuProcess
                    running: true
                    command: [ "sh", "-c", "echo $[100-$(vmstat 1 2|tail -1|awk '{print $15}')]" ]
                    stdout: StdioCollector {
                        onStreamFinished: {
                            resourcesModule.cpuPercentage = this.text
                        }
                    }
                }

                Process {
                    id: temperatureProcess
                    running: true
                    command: [ "sh", "-c", "sensors | awk '/junction/ { print int($2) }'" ]
                    stdout: StdioCollector {
                        onStreamFinished: {
                            resourcesModule.temperature = this.text
                        }
                    }
                }
            }

            // --- Date ---
            Module {
                underlineColor: Colorscheme.dateColor
                id: dateModule

                function getCurrentDateTime() {
                    let now = new Date()
                    let day = now.getDate().toString().padStart(2, '0')
                    let month = (now.getMonth() + 1).toString().padStart(2, '0')
                    let year = now.getFullYear()
                    let hour = now.getHours().toString().padStart(2, '0')
                    let minute = now.getMinutes().toString().padStart(2, '0')
                    return `${day}/${month}/${year} ${hour}:${minute}`
                }

                property string currentDateTime: getCurrentDateTime()

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: dateModule.currentDateTime = dateModule.getCurrentDateTime()
                }

                MyText {
                    text: ""
                    rightPadding: padding_
                    color: Colorscheme.dateColor
                }

                MyText {
                    text: dateModule.currentDateTime
                }
            }
        }
    }
}