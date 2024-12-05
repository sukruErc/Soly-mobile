import 'package:flutter/material.dart';
import 'package:get/get.dart';

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