import 'package:deva_test/models/FakeData/adress.dart';
import 'package:deva_test/models/addresses/district_model.dart';
import 'package:deva_test/tools/styles.dart';
import 'package:deva_test/tools/validations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';


class DistrictDropdown extends StatelessWidget {
  int ProvincialID;
  Function onChange;
  DistrictDropdown({this.ProvincialID,this.onChange});

  getDis(ProvincialID){
    if(ProvincialID!=null)
      return Adress.GetDistrict();
  }
  Widget _customDropDownExample(
      BuildContext context, District item, String itemDesignation) {
    return Container(
        child:
        (item?.DistrictName == null)
            ? ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text("İlçe Seçiniz",style: textStyle,),
        )
            :ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(item.DistrictName,style: textStyle,),
        )
    );
  }
  Widget _customPopupItemBuilderExample(
      BuildContext context, District item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color:Colors.white),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(item.DistrictName,style: textStyle,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<District>(
      mode: Mode.DIALOG,
      popupBackgroundColor: Colors.blue,
      searchBoxDecoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),
          focusColor: Colors.white,
          labelStyle: textStyle,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          )
      ),
      dropdownSearchDecoration: InputDecoration(
          border: InputBorder.none,
          labelStyle: textStyle,
          prefixIcon: Icon(Icons.map,color: Colors.white)
      ),
      items: getDis(ProvincialID),//DropDownDataları Getirilcek gelen ID
      showSearchBox: true,
      hint: "İlçe",
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator:(val)=>FormValidations.DistrictValidation(val),
      //popupItemDisabled: (Provincial s) => s.ID==2,
      onChanged:(District d)=>onChange(d.ID),
      popupTitle: Center(child: Padding(
        padding:EdgeInsets.all(8.0),
        child: Text("İlçe Seç",style: TextStyle(
            color: Colors.white
        ),),
      )
      ),
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );
  }


}
