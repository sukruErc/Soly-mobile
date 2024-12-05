import 'dart:convert';

import 'package:get/get.dart';
import 'package:solyticket/model/my_activity_json.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/my_activity/repo/my_activity_repo.dart';

class MyActivityController extends GetxController {

  MyActivityRepo repo;var myActivityJson =
      MyActivityJson(success: false, date: null, data: []).obs;

  MyActivityController(this.repo);

  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getActivities();
  }

  getActivities() async {
    var data = {
      "userId": "d5f17232-ed49-48a4-910f-9b29d95efdf6",
    };
    try {
      await repo.getMyActivities(data).then((response) {
        if (response!.statusCode == 200) {
          var res = jsonDecode(response.data);
          if (res["success"] == true) {
            myActivityJson.value = MyActivityJson.fromJson(res);
          } else {}
        }
      });
    } catch (e) {
      // do nothing here
    }
  }
}
