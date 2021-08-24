import 'package:deva_test/data/view_models/dashboard_view_model.dart';
import 'package:deva_test/data/view_models/security_view_model.dart';
import 'package:deva_test/data/view_models/work_group_view_model.dart';
import 'package:deva_test/tools/locator.dart';
import 'package:provider/provider.dart';

class UowProviders{
  static getProviders(context){
    return [
      ChangeNotifierProvider<SecurityViewModel>(
        create: (context)=>locator<SecurityViewModel>(),
      ),
    ];
  }
}