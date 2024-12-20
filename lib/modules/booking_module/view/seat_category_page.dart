import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/booking_module/controller/seat_category_controller.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/strings.dart';
import 'package:solyticket/widgets/app_layout.dart';
import 'package:solyticket/widgets/custom_loader_button.dart';

import '../../../model/seat_category_json.dart';

class SeatCategoryPage extends GetView<SeatCategoryController> {
  const SeatCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultAppLayout(
      title: const Text("Seat Category"),
      isAppBar: true,
      leading: backButton(),
      child: Column(
        children: [
          verticalGap(15),
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonFormField<String>(
                  value: controller.selectedCategory.value,
                  decoration: InputDecoration(
                    hintText: 'Select Sort Order...',
                    suffixIcon: controller.selectedCategory.value == null
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              controller.selectedCategory.value = null;
                            }),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(color: DefaultTheme().textFieldColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(color: DefaultTheme().textFieldColor),
                    ),
                  ),
                  onChanged: (newValue) {
                    controller.selectedCategory.value = newValue;
                  },
                  items: controller.seatCategories.value.data?.categories
                      .map<DropdownMenuItem<String>>((Category value) {
                    return DropdownMenuItem<String>(
                      value: value.id,
                      child: Text(value.label),
                    );
                  }).toList(),
                ),
              )),
          verticalGap(15),
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonFormField<String>(
                  value: controller.numberOfPerson.value,
                  decoration: InputDecoration(
                    hintText: 'Select Sort Order...',
                    suffixIcon: controller.numberOfPerson.value == null
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              controller.numberOfPerson.value = null;
                            }),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(color: DefaultTheme().textFieldColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(color: DefaultTheme().textFieldColor),
                    ),
                  ),
                  onChanged: (newValue) {
                    controller.numberOfPerson.value = newValue;
                  },
                  items: controller.seatCategories.value.data?.numberOfPerson
                      .map<DropdownMenuItem<String>>((NumberOfPerson value) {
                    return DropdownMenuItem<String>(
                      value: value.id,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              )),
          const Spacer(),
          SizedBox(width:Get.width,child: CustomLoaderButton(
            btnText: AppStrings.done,
            radius: 0,
            onTap: () async {
              if(controller.numberOfPerson.value!=null||controller.numberOfPerson.value!=null){
                Get.toNamed("seat-selection",arguments: [controller.eventId.value,controller.selectedCategory.value]);
              }else{
                snack(AppStrings.selectBookingCg, isError: true);
              }
            }, isLoading: false,
          ))
        ],
      ),
    );
  }

  backButton() {
    return IconButton(
        padding: const EdgeInsets.only(right: 3),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 22,
        ));
  }
}
