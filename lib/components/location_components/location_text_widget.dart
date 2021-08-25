import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationTextWidget extends StatefulWidget {
///İos için izinler alınacak https://pub.dev/packages/location
  Function onChange;
  String initVal;
  String label;

  LocationTextWidget({this.initVal,this.onChange});

  @override
  _LocationTextWidgetState createState() => _LocationTextWidgetState();
}

class _LocationTextWidgetState extends State<LocationTextWidget> {
  TextEditingController locationText;
  var _location= Location();
  PermissionStatus _permissionStatus;
  LocationData _locationData;
  bool _isServiceEnable;
  @override
  void initState() {
    locationText=TextEditingController(text: widget.initVal??"");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: locationText,
            decoration: InputDecoration(
              labelText: widget.label??"Konum",
              hintText: widget.label??"Konum"
            ),
            onChanged: (val){
              widget.onChange(val);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: TextButton(
            child: Icon(Icons.add_location),
            onPressed: () async {
              _isServiceEnable=await _location.serviceEnabled();
              if(!_isServiceEnable){
                _isServiceEnable= await  _location.requestService();
                if(_isServiceEnable) return;
              }
              _permissionStatus=await _location.hasPermission();
              if(_permissionStatus==PermissionStatus.denied){
                _permissionStatus=await _location.requestPermission();
                if(_permissionStatus!= PermissionStatus.granted) return;
              }
              _locationData=await _location.getLocation();
              setState(() {
                var text="${_locationData.latitude} ${_locationData.longitude}";
                locationText.text=text;
                widget.onChange(text);
              });


            },
          ),
        )
      ],
    );
  }
}
