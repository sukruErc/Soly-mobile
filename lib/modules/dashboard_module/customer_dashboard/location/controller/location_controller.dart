import 'dart:convert';
import 'package:get/get.dart';
import 'package:solyticket/model/location_cities_json.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/location/repo/location_repo.dart';

class LocationController extends GetxController {
  LocationRepo locationRepo;
  var locationList = LocationInCitiesJson(data: []).obs;
  var isLoading = false.obs;
  LocationController({required this.locationRepo});

  @override
  void onInit() {
    getLocations();
    // TODO: implement onInit
    super.onInit();
  }

  getLocations() async {
    await locationRepo.getLocationsFromServer().then((response) {
      if (response!.statusCode == 200) {
        var searchResult = json.decode(response.data);
        if(searchResult["success"]==true){
          isLoading(false);
          locationList.value = LocationInCitiesJson.fromJson(searchResult);
        }else{
          isLoading(false);
        }
      }
    });
  }
}
