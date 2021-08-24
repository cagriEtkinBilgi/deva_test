import 'package:cached_network_image/cached_network_image.dart';
import 'package:deva_test/tools/apptool.dart';
import 'package:flutter/material.dart';

class AttachmentImageWidget extends StatelessWidget {
  String Uri;
  AttachmentImageWidget({@required this.Uri});
  @override
  Widget build(BuildContext context) {
    if(Uri!=null){
      return CachedNetworkImage(
        imageUrl: AppTools.apiUri+ Uri,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.fill,
      );
    }else{
      return Icon(Icons.account_box_outlined);
    }
  }
}
