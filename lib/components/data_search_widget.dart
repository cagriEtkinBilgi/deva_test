import 'package:deva_test/data/view_models/search_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/search_models/search_list_model.dart';
import 'package:deva_test/screens/base_class/base_view.dart';
import 'package:deva_test/tools/locator.dart';
import 'package:flutter/material.dart';


import 'build_progress_widget.dart';


class DataSearch extends SearchDelegate{
  int pageID;
  DataSearch({
    String hintText = "Ara",
    this.pageID
  }) : super(
    searchFieldLabel: hintText,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.search,
  );

  var vm=locator<SearchViewModel>();

  var results=List<SearchListModel>();

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query="";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);  //geri butonuna basıldığında bu yapılacak
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return buildResultDetail(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.length>3){
      return FutureBuilder(
          future: vm.getSearchResults(pageID, query),
          builder: (context,AsyncSnapshot projectSnap) {
            if (projectSnap.connectionState == ConnectionState.none ||
                projectSnap.hasData == false) {
              return ProgressWidget();
            }else{
              results = projectSnap.data;
              return buildResultDetail(context);
            }
          }
      );
    }else{
      return Center(
        child:Text("Lütfen Aranacak Kelime Yazınız") ,
      );
    }
  }

  Widget buildResultDetail(BuildContext context)
  {
    if(results.length==0){
      return Center(
        child:Text("Gösterilecek Veri Yok"),
      );
    }else{
      return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context,i){
            var result=results[i];
            return ListTile(
              title: Text(result.title),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: (){
                buildPageUrl(
                    result.id,
                    result.title,
                    context
                );
              },
            );
          }
      );
    }

  }

  void buildPageUrl(int id,String title,BuildContext context) {
    if(pageID==2){
      Navigator.pushNamed<dynamic>(context,'/ActivitiesDetailPage',arguments: {"id":id,"title":title});
    }else if(pageID==3){
      Navigator.pushNamed<dynamic>(context,'/TaskDetailPage',arguments: {
        "id":id,
        "title":title
      });
    }
  }


  
}
