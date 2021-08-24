import 'package:deva_test/models/base_models/base_list_model.dart';
import 'package:deva_test/models/search_models/search_list_model.dart';

import 'base_api.dart';

class SearchRepository{



  Future<BaseListModel> getSearchResults(String token, int type,String query) async {
    try {

      BaseListModel<SearchListModel> response =
      await BaseApi.instance.dioGet<SearchListModel>(
          "/Search/GetSearch/", SearchListModel(),
          params: {"type":type,"q":query.toLowerCase().trim()},
          token: token);
      print(response.datas);
      return response;
    } catch (e) {
      throw e;
    }
  }

}