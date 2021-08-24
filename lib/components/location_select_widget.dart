import 'package:deva_test/components/text_field_date_picker_widget.dart';
import 'package:deva_test/components/text_field_date_time_picker_widget.dart';
import 'package:deva_test/models/component_models/dropdown_search_model.dart';
import 'package:deva_test/tools/apptool.dart';
import 'package:flutter/material.dart';
import 'dropdown_serach_widget.dart';

class LocationSelectWidget extends StatefulWidget {
  int selectedid;
  String initDate;
  Function onChange;
  LocationSelectWidget({this.selectedid=0,this.initDate,this.onChange});

  @override
  _LocationSelectWidgetState createState() => _LocationSelectWidgetState();
}

class _LocationSelectWidgetState extends State<LocationSelectWidget> {

  bool visibilty;
  @override
  void initState() {
    visibilty=(widget.selectedid!=0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          DropdownSerachWidget(
            items: AppTools.getRepetitionStatus(),
            dropdownLabel: " Tekrar Durumu",
            selectedId: widget.selectedid,
            onChange: (DropdownSearchModel val){
              setState(() {
                widget.selectedid=val.id;
                visibilty=(val.id!=0);
              });
            },
          ),
          SizedBox(
            height: 5,
          ),
          Visibility(
            visible: visibilty,
            child: TextFieldDateTimePickerWidget(
              initDate: widget.initDate,
              dateLabel: "Son Tarihi",
              timeLabel: "Saat",
              onChangedDate: (date,time){
                widget.onChange(widget.selectedid,date);
              },
            ),
          ),
        ],
      ),
    );
  }
}
