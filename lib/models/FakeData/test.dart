import 'package:deva_test/models/component_models/check_list_model.dart';
import 'package:deva_test/models/component_models/dropdown_search_model.dart';

class FakeCheck{

  static List<CheckListModel> getCheckList(){
    var models=new List<CheckListModel>();
    for(var i=0;i<=20;i++){
      models.add(CheckListModel(id: i,name: "çağrı $i",value: false));
    }
    return models;
  }
  static List<DropdownSearchModel> getDrop(){
    var models=List<DropdownSearchModel>();
    for(var i=0;i<20;i++){
      models.add(DropdownSearchModel(id: i,value: "Drp $i"));
    }
    return models;
  }
}