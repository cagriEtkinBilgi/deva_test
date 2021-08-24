import 'package:deva_test/models/FakeData/adress.dart';
import 'package:deva_test/models/addresses/provincial_model.dart';
import 'package:deva_test/tools/styles.dart';
import 'package:deva_test/tools/validations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ProvincialDropdown extends StatelessWidget {
  Function onChange;

  ProvincialDropdown({this.onChange});

  Widget _customDropDownExample(
      BuildContext context, Provincial item, String itemDesignation) {
    return Container(
        child:
        (item?.CityName == null)
            ? ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text("İl Seçiniz",style: textStyle,),
        )
            :ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(item.CityName,style: textStyle,),
        )
    );
  }
  Widget _customPopupItemBuilderExample(
      BuildContext context, Provincial item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(

        title: Text(item.CityName,style: textStyle,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Provincial>(

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
      items: Adress.GetProvincial(),//DropDownDataları Getirilcek
      showSearchBox: true,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator:(val)=>FormValidations.ProvincialValidation(val),
      hint: "İl",
      //popupItemDisabled: (Provincial s) => s.ID==2,
      onChanged:(Provincial d)=>onChange(d.ID),
      popupTitle: Center(child: Padding(
        padding:EdgeInsets.all(8.0),
        child: Text("İl Seç",style: TextStyle(
            color: Colors.white
        ),),
      )
      ),
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );
  }
}

