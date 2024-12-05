import 'package:get/get.dart';
import 'package:solyticket/modules/authentication_module/otp/controller/otp_controller.dart';
import 'package:solyticket/modules/authentication_module/otp/repo/otp_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpController(repo: OtpRepo(apiClient: ApiClient())));
    // TODO: implement dependencies
  }
}
