import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/common_controllers/image_picker_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/profile/repo/profile_repo.dart';

class ProfileController extends GetxController {
  ProfileRepo profileRepo;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  ImagePickerController imageController = Get.put(ImagePickerController());
  final formKey = GlobalKey<FormState>();

  ProfileController(this.profileRepo);
}
