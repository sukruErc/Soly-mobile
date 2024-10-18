import 'package:get/get.dart';
import 'package:solyticket/modules/authentication_module/registration/controller/registration_controller.dart';
import 'package:solyticket/modules/authentication_module/registration/repo/registration_repository.dart';
import 'package:solyticket/providers/api_client.dart';

class RegistrationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(RegistrationController(repo: RegistrationRepository(apiClient: ApiClient())));
    // TODO: implement dependencies
  }
}