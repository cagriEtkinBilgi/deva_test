import 'package:date_format/date_format.dart';
import 'package:deva_test/tools/date_parse.dart';
import 'package:flutter/material.dart';

class TextFieldDateTimePickerWidget extends StatefulWidget {
  Function onChangedDate;
  String dateLabel;
  String timeLabel;
  DateTime initDateTime;
  TimeOfDay initTime;

  TextFieldDateTimePickerWidget({this.dateLabel,this.timeLabel,
    this.onChangedDate,String initDate,
    String initTimeStr}){

    if(initDate!=null)
      initDateTime= DateParseTools.instance.StrToDate(initDate);
    else
      initDateTime= DateTime.now();
    if(initTimeStr!=null)
      initTime= DateParseTools.instance.StrToTime(initTimeStr);
    else
      initTime= TimeOfDay(hour: 12,minute: 30);
  }

  @override
  _TextFieldDateTimePickerWidgetState createState() => _TextFieldDateTimePickerWidgetState();
}

class _TextFieldDateTimePickerWidgetState extends State<TextFieldDateTimePickerWidget> {
  var textControllerDate=TextEditingController();
  var textControllerTime=TextEditingController();
  String selectedDate;
  String selectedMinute;

  @override
  void initState() {
    textControllerDate.text =formatDate(widget.initDateTime, [dd, '.', mm, '.', yyyy]);
    textControllerTime.text=widget.initTime.hour.toString()+":"+widget.initTime.minute.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              child: InkWell(
                onTap: (){
                  buldDatePicker(context);
                },
                child: buildDateProp(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: InkWell(
                onTap: (){
                  buldTimePicker(context);
                },
                child: buildTimeProp(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateProp(){
    return TextField(
      controller: textControllerDate,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
        labelText: widget.dateLabel,
        hintText: widget.dateLabel,
      ),
      onTap: () => buldDatePicker(context),
      readOnly: true,
    );
  }
  Widget buildTimeProp(){
    return TextField(
      controller: textControllerTime,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.access_time_outlined),
          labelText: widget.timeLabel,
          hintText: widget.timeLabel
      ),
      onTap: () => buldTimePicker(context),
      readOnly: true,
    );
  }

  buldDatePicker(context) async {
    var picketDate=await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if(picketDate!=null){
      setState(() {
        selectedDate=formatDate(picketDate, [dd, '.', mm, '.', yyyy]);
        textControllerDate.text=selectedDate;
        widget.onChangedDate(selectedDate,selectedMinute);
      });
    }
    return picketDate;
  }

  buldTimePicker(BuildContext context) async {
    var picketTime=await showTimePicker(
      context: context,
      initialTime:TimeOfDay.now(),
    );
    setState(() {
      selectedMinute=picketTime.format(context);
      textControllerTime.text=selectedMinute;
      widget.onChangedDate(selectedDate,selectedMinute);
    });
  }
}
