import 'package:get/get.dart';
import 'package:solyticket/modules/authentication_module/login/controller/login_controller.dart';
import 'package:solyticket/modules/authentication_module/login/repo/login_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(repo: LoginRepository(apiClient: ApiClient())));
    // TODO: implement dependencies
  }
}
