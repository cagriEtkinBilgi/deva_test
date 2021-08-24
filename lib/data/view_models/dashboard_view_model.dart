import 'package:deva_test/data/repositorys/dashboard_repository.dart';
import 'package:deva_test/data/view_models/base_view_model.dart';
import 'package:deva_test/data/view_models/security_view_model.dart';
import 'package:deva_test/enums/api_state.dart';
import 'package:deva_test/models/dashboardmodels/dashboard_model.dart';
import 'package:deva_test/tools/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';



class DashboardViewModel extends BaseViewModel {

  DashboardModel _dashboard;

  DashboardModel get dashboard => _dashboard;

  set dashboard(DashboardModel value) {
    _dashboard = value;
  }

  var repo=locator<DashboardRepository>();

  Future<DashboardModel> getDashboard() async {
    try{
      var sesion=await SecurityViewModel().getCurrentSesion();
      dashboard= await repo.GetDashboard(sesion.token);
      setState(ApiStateEnum.LoadedState);
      return dashboard;
    }catch(e){
      setState(ApiStateEnum.ErorState);
      onError=e;
    }
  }

}