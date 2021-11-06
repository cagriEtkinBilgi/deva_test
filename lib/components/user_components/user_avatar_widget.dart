import 'package:cached_network_image/cached_network_image.dart';
import 'package:deva_test/tools/apptool.dart';
import 'package:flutter/material.dart';

class UserAvatarWidget extends StatelessWidget {
  String url;
  UserAvatarWidget({Key key,this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(url!=null){
      return CachedNetworkImage(
        fit: BoxFit.fitHeight,
        imageUrl: AppTools.apiUri+url,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(
          Icons.error_outline,
          size: 50,
        ),
      );
    }else{
      return Icon(
        Icons.account_circle,
        size: 100,
      );
    }
  }
}
