import QtQuick 2.0
import QtQuick.Dialogs 1.1
Item {
    function opening(){
        deletedialog.open();
    }
    MessageDialog{
        id:deletedialog
        text:"Вы уверены, что хотите удалить трек?"
        standardButtons: StandardButton.Yes | StandardButton.No
        Component.onCompleted: visible = false
        onYes: {delete_track();deletedialog.close();}
        onNo: deletedialog.close()

    }
}
