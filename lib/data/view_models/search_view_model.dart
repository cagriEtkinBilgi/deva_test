import 'package:deva_test/data/repositorys/search_repository.dart';
import 'package:deva_test/data/view_models/base_view_model.dart';
import 'package:deva_test/data/view_models/security_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/base_models/base_list_model.dart';
import 'package:deva_test/models/search_models/search_list_model.dart';
import 'package:deva_test/tools/locator.dart';

import '../error_model.dart';

class SearchViewModel extends BaseViewModel{

  var repo=locator<SearchRepository>();

  List<SearchListModel> results;

  SearchViewModel(){
    setState(ApiStateEnum.LoadedState);
  }

  Future<List<SearchListModel>> getSearchResults(int typeID,String query) async {
    try{
      setState(ApiStateEnum.LodingState);
      var sesion=await SecurityViewModel().getCurrentSesion();
      BaseListModel<SearchListModel> retVal;
      retVal=await repo.getSearchResults(sesion.token, typeID,query);
      results=retVal.datas;
      canEdit=(retVal.outarized==2);
      setState(ApiStateEnum.LoadedState);
      return results;
    }catch(e){
      if(e is ErrorModel){
        onError=e;
      }else{
        onError.message=e.toString();
      }
      setState(ApiStateEnum.ErorState);
      throw e;
    }
  }


}