import QtQuick 2.0
import QtQuick.Dialogs 1.1
Item {
    function opening(){
        exitdialog.open();
    }
    MessageDialog{
        id:exitdialog
        text:"Выйти из программы?"
        standardButtons: StandardButton.Yes | StandardButton.No
        Component.onCompleted: visible = false
        onYes: Qt.exit(0)
        onNo: exitdialog.close()

    }
}
