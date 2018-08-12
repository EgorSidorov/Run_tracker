import QtQuick 2.0
import QtQuick.Dialogs 1.1
Item {
    id:lowsignaldialogitem
    function opening(){
        lowsignaldialog.open();
    }
    MessageDialog{
        id:lowsignaldialog
        text:quality_signal==0 ? "Нет сигнала GPS.\n\nНачать бег?":"Слабый сигнал GPS.\n\nНачать бег?"
        standardButtons: StandardButton.Yes | StandardButton.No
        Component.onCompleted: visible = false
        onYes: {on_run_clicked();close();}
        onNo: close()

    }
}
