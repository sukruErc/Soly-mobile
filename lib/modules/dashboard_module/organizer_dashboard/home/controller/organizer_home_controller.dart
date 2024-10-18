import 'dart:convert';
import 'package:get/get.dart';
import 'package:solyticket/model/organizer_home_json.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/home/repo/organizer_home_repo.dart';

class OrganizerHomeController extends GetxController{
  var organizerHomeData = OrganizerHomeJson().obs;
  OrganizerHomeRepo repo;
  var isLoading = false.obs;
  OrganizerHomeController(this.repo);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHomeData();
  }
  getHomeData() async {
    isLoading.value = true;
    try{
      var data = {
        "userId": "7bcfb642-7241-4962-a664-83409aa18172",
      };
      await repo.getHomeData(data).then((response) {
        if(response!.statusCode==200){
          var res = jsonDecode(response.data);
          if(res["success"]==true){
            isLoading.value = false;
            organizerHomeData.value = OrganizerHomeJson.fromJson(res);
          }else{
            isLoading.value = true;
          }
        }
      });
    }catch(e){
      isLoading.value = false;
      print(e);
    }
  }
}
