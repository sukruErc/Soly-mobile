import 'package:get/get.dart';

class InternetConnectivityController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  // final _connectionType = MConnectivityResult.none.obs;
  // late final Connectivity connectivity;
  //
  // MConnectivityResult get connectionType => _connectionType.value;
  //
  // set connectionType(value) {
  //   _connectionType.value = value;
  // }
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   connectivity = Connectivity();
  //   connectivity.onConnectivityChanged.listen(updateConnectionState);
  // }
  //
  // updateConnectionState(var event) {
  //   switch (event) {
  //     case ConnectivityResult.wifi:
  //       connectionType = MConnectivityResult.wifi;
  //       break;
  //     case ConnectivityResult.mobile:
  //       connectionType = MConnectivityResult.mobile;
  //       break;
  //     case ConnectivityResult.none:
  //       connectionType = MConnectivityResult.none;
  //       break;
  //     default:
  //       print('Failed to get connection type');
  //       break;
  //   }
  // }
}

enum MConnectivityResult { none, wifi, mobile }
