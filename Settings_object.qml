import QtQuick 2.0

Item {
    function get_weight() {
        return settings.weight
    }
    function set_weight(weight) {
        settings.weight = weight
    }
    function get_line_1_color() {
        return settings.line_1_color
    }
    function set_line_1_color(line_1_color) {
        settings.line_1_color = line_1_color
    }
    function get_line_2_color() {
        return settings.line_2_color
    }
    function set_line_2_color(line_2_color) {
        settings.line_2_color = line_2_color
    }
    function get_line_3_color() {
        return settings.line_3_color
    }
    function set_line_3_color(line_3_color) {
        settings.line_3_color = line_3_color
    }
    function get_line_4_color() {
        return settings.line_4_color
    }
    function set_line_4_color(line_4_color) {
        settings.line_4_color = line_4_color
    }
    Settings {
        id: settings
        property int weight: 50
        property string line_1_color: "red"
        property string line_2_color: "orange"
        property string line_3_color: "yellow"
        property string line_4_color: "green"
    }
}
