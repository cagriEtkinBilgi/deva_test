import 'package:deva_test/models/addresses/district_model.dart';
import 'package:deva_test/models/addresses/neighborhood_model.dart';
import 'package:deva_test/models/addresses/provincial_model.dart';


class Adress{

  static List<Neighborhood> GetNeig(){
    var list=List<Neighborhood>();
    for(var i=0;i<=20;i++){
      list.add(Neighborhood(ID: i,NeighborhoodName: "Mahalle"+i.toString(),DistrictID: i,ProvincialID: i));
    }
    return list;
  }

  static List<District> GetDistrict(){
    var list=List<District>();
    for(var i=0;i<=20;i++){
      list.add(District(ID: i,DistrictName:"ilçe "+i.toString(),ProvincialID: i));
    }
    return list;
  }

  static List<Provincial> GetProvincial(){
    var list=List<Provincial>();
    for(var i=0;i<=20;i++){
      list.add(Provincial(ID: i,CityName: "il "+i.toString(),RegionID:i));
    }
    return list;
  }


}