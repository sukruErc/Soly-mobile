import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/controller/customer_home_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/repo/customer_home_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class CustomerDashboardController extends GetxController{
  var bottomSelectedIndex=0.obs;
  late PageController bottomController;
  @override
  void onInit() {
    bottomController = PageController(initialPage: bottomSelectedIndex.value);
    // TODO: implement onInit
    super.onInit();
  }
}