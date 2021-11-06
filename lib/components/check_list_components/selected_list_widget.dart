import 'package:deva_test/models/component_models/select_list_widget_model.dart';
import 'package:flutter/material.dart';

class SelectedListWidget extends StatefulWidget {

  List<SelectListWidgetModel> items;
  Function onChangeStatus;
  String title;
  IconButton extraButton;
  bool multiple;
  double height;
  List q=[];
  SelectedListWidget({
    this.items,
    this.title = "",
    this.multiple = false,
    this.onChangeStatus,
    this.extraButton,
    this.height,
  }){
    q=items;
  }
  @override
  _SelectedListWidgetState createState() => _SelectedListWidgetState();
}

class _SelectedListWidgetState extends State<SelectedListWidget> {

  bool _showSearch=false;
  bool _selectedAll=false;

  @override
  Widget build(BuildContext context) {
    if(widget.height==null)
      widget.height=MediaQuery.of(context).size.height-300;
    return Column(
      children: [
        _buildHeader(),
        Divider(color: Colors.black,),
        Container(
          height: widget.height,
          child: _buildSeletcList()
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Visibility(
          visible: !_showSearch,
          child: Row(
            children: [
              Text(widget.title),
              Spacer(),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  setState(() {
                    _showSearch=true;
                  });
                },
              ),

              (widget.multiple)?IconButton(
                icon: Icon(Icons.select_all_outlined),
                onPressed: (){
                  setState(() {
                    if(!_selectedAll){
                      _selectedAll=true;
                      for(var item in widget.items)
                        item.selected=true;
                    }else{
                      _selectedAll=false;
                      for(var item in widget.items)
                        item.selected=false;
                    }
                    widget.onChangeStatus(widget.items.where((element) => element.selected==true).toList());

                  });
                },
              ):Container(),
              (widget.extraButton!=null)?widget.extraButton:Container()
            ],
          ),
        ),
        Visibility(
          visible: _showSearch,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  setState(() {
                    _showSearch=false;
                    widget.q=widget.items;
                  });
                },
              ),
              Expanded(
                flex: 5,
                  child:TextField(
                    decoration: InputDecoration(
                      hintText: "Ara"
                    ),
                    onChanged: (String val){
                      if(val.length!=0){
                        setState(() {
                          widget.q= widget.items.where((e) => e.toString().toLowerCase().contains(val.toLowerCase())).toList();//test edeilecek
                        });
                      }else
                        setState(() {
                          widget.q=widget.items;
                        });
                    },
                  )
              )

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSeletcList() {
    return ListView.builder(
      itemCount: widget.q.length,
      itemBuilder: (context,i){
        return _buildItemCard(widget.q[i]);
      }
    );
  }

  Widget _buildItemCard(SelectListWidgetModel model) {
    //item cartlar tasarlacak
    if(model.selected==null)
      model.selected=false;

    return Card(
      child: Container(
        color: (model.selected)?Colors.blue.shade200:Colors.transparent,
        child: ListTile(
          title: Text(model.title??"boş"),
          subtitle: Text(model.subTitle??""),
          onTap: (){
            setState(() {
              if(!widget.multiple){
                for(var item in widget.items)
                  item.selected=false;
              }
              model.selected=!model.selected;
              widget.onChangeStatus(widget.items.where((element) => element.selected==true).toList());
            });
          },
        ),
      ),
    );
  }
}
