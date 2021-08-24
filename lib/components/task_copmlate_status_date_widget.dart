import 'package:deva_test/components/text_field_date_picker_widget.dart';
import 'package:deva_test/models/component_models/dropdown_search_model.dart';
import 'package:deva_test/models/task_models/task_status_form_model.dart';
import 'package:deva_test/tools/apptool.dart';
import 'package:flutter/material.dart';

class TaskCoplateStatusDate extends StatefulWidget {
  int initVal;
  Function onChangeStatus;
  String initDate;
  var model=TaskStatusFormModel();
  TaskCoplateStatusDate({
    int init,
    this.initDate,
    this.onChangeStatus,
  }){
  if(init!=null)
    initVal=init;
  else
    initVal=0;
  }

  @override
  _TaskCoplateStatusDateState createState() => _TaskCoplateStatusDateState();
}

class _TaskCoplateStatusDateState extends State<TaskCoplateStatusDate> {

  bool showStartDate=false;
  bool showEndDate=false;
  List<DropdownMenuItem<int>> items;

  @override
  void initState() {
    items=_getItems();
    widget.model.taskStatus=widget.initVal;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Durum Güncelle:",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              DropdownButton<int>(
                value: widget.model.taskStatus,
                items: items,
                onChanged: (selected){
                  setState(() {
                    widget.model.taskStatus=selected;
                    widget.onChangeStatus(widget.model);
                    _prepareDates();
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Visibility(
            visible: showStartDate,
            child: TextFieldDatePickerWidget(
              initDate: widget.initDate,
              dateLabel: "Başlangıç Tarihi",
              onChangedDate: (startDate){
                widget.model.startDate=startDate;
                widget.onChangeStatus(widget.model);
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Visibility(
            visible: showEndDate,
            child: TextFieldDatePickerWidget(
              initDate: widget.initDate,
              dateLabel: "Bitiş Tarihi",
              onChangedDate: (endDate){
                widget.model.endDate=endDate;
                widget.onChangeStatus(widget.model);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _prepareDates() {
      switch(widget.model.taskStatus){
        case 0:
          showEndDate=false;
          showStartDate=false;
          break;
        case 1:
          showEndDate=false;
          showStartDate=true;
          break;
        case 2:
          showEndDate=true;
          showStartDate=true;
          break;
        case 3:
          showEndDate=false;
          showStartDate=false;
          break;
        case 4:
          showEndDate=false;
          showStartDate=false;
          break;
      }
  }

  List<DropdownMenuItem<int>> _getItems() {
    var menuItems=AppTools.getTaskStatus();
    var items=List<DropdownMenuItem<int>>();
    for(var item in menuItems){
      items.add(DropdownMenuItem<int> (child: Text(item.value),value:item.id,));
    }
    return items;
  }

}
