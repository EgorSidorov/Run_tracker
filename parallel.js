var last_speed_level=0;//0-скорость первая.1-до 4 км/ч, 2-до 8 км/ч,3-до 12 км/ч, 4-от 12 км/ч
var track_dynamic;
var last_coordinate;
function add_coord(haspause,latitude,longitude,level,color,mapp){
    if(haspause==true||last_speed_level==0){
        track_dynamic = Qt.createQmlObject('import QtLocation 5.6; MapPolyline {}', root);
                track_dynamic.line.width = 9;
                track_dynamic.line.color = color;
        track_dynamic.addCoordinate(QtPositioning.coordinate(latitude,longitude));
        mapp.addMapItem(track_dynamic);
    }
    else if(last_speed_level!=level){
        track_dynamic = Qt.createQmlObject('import QtLocation 5.6; MapPolyline {}', root);
                track_dynamic.line.width = 9;
                track_dynamic.line.color = color;
        track_dynamic.addCoordinate(last_coordinate);
        track_dynamic.addCoordinate(QtPositioning.coordinate(latitude,longitude));
        mapp.addMapItem(track_dynamic);
    } else {
        track_dynamic.addCoordinate(QtPositioning.coordinate(latitude,longitude));
    }
}

WorkerScript.onMessage=function(){
    progressbar.visible=true;
    database.write_all_in_dynamic_massiv(button.state);
    var count_point=database.count_point(button.state);
    for(var i=1;i<count_point+1;i++){
      var current_speed=database.get_point_speed(button.state,i);
        var latitude=database.get_point_latitude(button.state,i);
        var longitude=database.get_point_longitude(button.state,i);
        if(current_speed<Obj_settings.get_level1()){
            add_coord(database.get_point_haspause(button.state,i),latitude,longitude,1,"red",mapp);
            last_speed_level=1;
        }
        else if(current_speed<Obj_settings.get_level2()){
            add_coord(database.get_point_haspause(button.state,i),latitude,longitude,2,"orange",mapp);
            last_speed_level=2;
        }
        else if(current_speed<Obj_settings.get_level3()){
            add_coord(database.get_point_haspause(button.state,i),latitude,longitude,3,"yellow",mapp);
            last_speed_level=3;
        }
        else{
            add_coord(database.get_point_haspause(button.state,i),latitude,longitude,4,"green",mapp);
            last_speed_level=4;
        }
        last_coordinate=QtPositioning.coordinate(latitude,longitude);
    }
   progressbar.visible=false;
}

