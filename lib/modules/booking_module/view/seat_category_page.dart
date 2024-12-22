import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/booking_module/controller/seat_category_controller.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/widgets/app_layout.dart';
import 'package:solyticket/widgets/custom_loader_button.dart';

import '../../../model/seat_category_json.dart';

class SeatCategoryPage extends GetView<SeatCategoryController> {
  const SeatCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultAppLayout(
      title: const Text("Bilet Kategorisi"),
      isAppBar: true,
      leading: geriTusu(),
      child: Column(
        children: [
          verticalGap(15),
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonFormField<String>(
                  value: controller.selectedCategory.value,
                  decoration: InputDecoration(
                    hintText: 'Sıralama Sırasını Seçin...',
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
                    controller.updateBlocks(newValue);
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
          Obx(() => controller.availableBlocks.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedBlock.value,
                    decoration: InputDecoration(
                      hintText: 'Blok Seçin...',
                      suffixIcon: controller.selectedBlock.value == null
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                controller.selectedBlock.value = null;
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
                      controller.selectedBlock.value = newValue;
                    },
                    items: controller.availableBlocks
                        .map<DropdownMenuItem<String>>((block) {
                      return DropdownMenuItem<String>(
                        value: block.id,
                        child: Text(block.label),
                      );
                    }).toList(),
                  ),
                )
              : SizedBox()),
          verticalGap(15),
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonFormField<String>(
                  value: controller.numberOfPerson.value,
                  decoration: InputDecoration(
                    hintText: 'Kisi Sayısını Seçin...',
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
          SizedBox(
              width: Get.width,
              child: CustomLoaderButton(
                btnText: "Koltuk Seçimine Geçin",
                radius: 0,
                onTap: () async {
                  if (controller.isSelectionComplete()) {
                    Get.toNamed("seat-selection", arguments: [
                      controller.eventId.value,
                      controller.selectedCategory.value,
                      controller.selectedBlock.value,
                      controller.numberOfPerson.value
                    ]);
                  } else {
                    snack("Lütfen tüm seçimleri yapın!", isError: true);
                  }
                },
                isLoading: false,
              ))
        ],
      ),
    );
  }

  geriTusu() {
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
