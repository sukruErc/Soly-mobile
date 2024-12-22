import 'package:get/get.dart';
import 'package:solyticket/modules/payment_module/controller/payment_contoller.dart';
import 'package:solyticket/modules/payment_module/repo/payment_repo.dart';
import 'package:solyticket/providers/api_client.dart';
class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(PaymentController(repo: PaymentRepo(apiClient: ApiClient())));
  }
}
