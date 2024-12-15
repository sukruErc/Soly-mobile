import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/collection/repo/collection_repo.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/collection/controller/collection_controller.dart';
import 'package:solyticket/providers/api_client.dart';

class CollectionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CollectionController(
          repo: CollectionRepo(apiClient: ApiClient()),
        ));
  }
}
