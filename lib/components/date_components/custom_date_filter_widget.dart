import 'package:deva_test/models/component_models/dropdown_search_model.dart';
import 'package:deva_test/tools/apptool.dart';
import 'package:flutter/material.dart';

class CustomDateWidget extends StatefulWidget {
  Function onChangeIndex;
  int selectedID;
   CustomDateWidget(
    {
      Key key,
      this.onChangeIndex,
      this.selectedID=-1,
    }) : super(key: key);

  @override
  _CustomDateWidgetState createState() => _CustomDateWidgetState();
}

class _CustomDateWidgetState extends State<CustomDateWidget> {

  var list= AppTools.getDateTypes();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,i){
          var item=list[i];
          return _builtListTile(item);
        },


      ),
    );
  }

  Widget _builtListTile(DropdownSearchModel item) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black,width: 1)),
        color: (item.id==widget.selectedID)?Colors.blue.shade200:Colors.transparent,
      ),
      height: 50,
      child: ListTile(
        title: Text(item.value),
        leading: Icon(Icons.arrow_back_ios),
        onTap: (){
          setState(() {
            widget.selectedID=item.id;
            widget.onChangeIndex(item.id);
          });


        },
      ),
    );
  }


}

