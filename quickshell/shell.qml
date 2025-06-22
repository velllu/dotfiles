import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.I3 
import QtQuick
import QtQuick.Controls
import Quickshell.Io
import "MyText.qml"

PanelWindow {
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

    implicitHeight: 30
        
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
            Column {
                id: palle
                topPadding: 5

                Row {
                    id: workspaceRow

                    leftPadding: padding_
                    rightPadding: padding_

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

                Rectangle {
                    width: workspaceRow.width
                    height: 3
                    color: Colorscheme.workspaceColor
                }
            }

            // --- Days since february 24th ---
            Column {
                id: sinceFebruary
                topPadding: 5

                property var startDate: new Date("2025-02-24")

                function get_days_since() {
                    let now = new Date()
                    let diffMs = now - startDate
                    return Math.floor(diffMs / (1000 * 60 * 60 * 24))
                }

                property int daysSince: get_days_since()

                Row {
                    id: februaryText
                    leftPadding: padding_
                    rightPadding: padding_

                    MyText {
                        text: ""
                        rightPadding: 4
                        color: Colorscheme.februaryColor
                    }

                    Timer {
                        interval: 60 * 1000

                        running: true
                        repeat: true

                        onTriggered: {
                            sinceFebruary.daysSince = get_days_since()
                        }
                    }

                    MyText {
                        text: `${sinceFebruary.daysSince} days`
                        color: Colorscheme.foreground
                    }
                }

                Rectangle {
                    width: februaryText.width
                    height: 3
                    color: Colorscheme.februaryColor
                }
            }
        }

        // --- RIGHT SIDE ---
        Row {
            anchors.right: parent.right
            anchors.rightMargin: standardPadding
            anchors.verticalCenter: parent.verticalCenter

            // --- Resources ---
            Column {
                id: resources
                topPadding: 5

                property int memoryPercentage: 0
                property int cpuPercentage: 0
                property int temperature: 0

                Row {
                    id: resourcesText

                    leftPadding: padding_
                    rightPadding: padding_

                    MyText {
                        text: ""
                        rightPadding: 4
                        color: Colorscheme.resourcesColor
                    }

                    MyText {
                        text: `${resources.memoryPercentage}%`
                        rightPadding: padding_
                    }

                    MyText {
                        text: "󰍛"
                        rightPadding: 4
                        color: Colorscheme.resourcesColor
                    }

                    MyText {
                        rightPadding: padding_
                        text: `${resources.cpuPercentage}%`
                    }

                    MyText {
                        text: ""
                        rightPadding: 4
                        color: Colorscheme.resourcesColor
                    }

                    MyText {
                        text: `${resources.temperature}°`
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
                                resources.memoryPercentage = this.text
                            }
                        }
                    }

                    Process {
                        id: cpuProcess
                        running: true
                        command: [ "sh", "-c", "echo $[100-$(vmstat 1 2|tail -1|awk '{print $15}')]" ]
                        stdout: StdioCollector {
                            onStreamFinished: {
                                resources.cpuPercentage = this.text
                            }
                        }
                    }

                    Process {
                        id: temperatureProcess
                        running: true
                        command: [ "sh", "-c", "sensors | awk '/junction/ { print int($2) }'" ]
                        stdout: StdioCollector {
                            onStreamFinished: {
                                resources.temperature = this.text
                            }
                        }
                    }
                }

                Rectangle {
                    width: resourcesText.width
                    height: 3
                    color: Colorscheme.resourcesColor
                }
            }

            // --- Date ---
            Column {
                id: date
                topPadding: 5

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

                Row {
                    id: dateText

                    leftPadding: padding_
                    rightPadding: padding_

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: date.currentDateTime = date.getCurrentDateTime()
                    }

                    MyText {
                        text: ""
                        rightPadding: 4
                        color: Colorscheme.dateColor
                    }

                    MyText {
                        text: date.currentDateTime
                    }
                }

                Rectangle {
                    width: dateText.width
                    height: 3
                    color: Colorscheme.dateColor
                }
            }
        }
    }
}