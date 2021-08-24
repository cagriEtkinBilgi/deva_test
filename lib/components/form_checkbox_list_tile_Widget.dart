import 'package:flutter/material.dart';

class FormCheckboxListTile extends StatefulWidget {
  bool initVal=false;
  String title;
  Function onChangedSelection;
  FormCheckboxListTile({@required this.title,this.initVal,this.onChangedSelection});
  @override
  _FormCheckboxListTileState createState() => _FormCheckboxListTileState();
}

class _FormCheckboxListTileState extends State<FormCheckboxListTile> {
  @override
  Widget build(BuildContext context) {
    if(widget.initVal==null)
        widget.initVal=false;
    return CheckboxListTile(
      title:Text(widget.title),
      value: widget.initVal,
      onChanged: (newValue) {
        setState(() {
          widget.initVal = newValue;
          widget.onChangedSelection(widget.initVal);
        });
      },
    );
  }
}
