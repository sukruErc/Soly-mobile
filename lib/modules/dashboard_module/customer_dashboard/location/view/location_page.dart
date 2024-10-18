import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/location/controller/location_controller.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/widget_formats.dart';

class LocationPage extends GetView<LocationController> {
  const LocationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: DefaultTheme().whiteColor,
        appBar: AppBar(
          leading: IconButton(
            padding: const EdgeInsets.only(right: 3),
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 22,
              )),
          backgroundColor: DefaultTheme().backgroundColor,
          centerTitle: true,
          title: Text(
            'Events Location',
            style: textDesigner(23, DefaultTheme().primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: controller.locationList.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  height: Media.height() * 0.170,
                  width: Media.width() * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: AssetImage(
                            controller.locationList[index]['image']),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                    top: Media.height() * 0.140,
                    left: Media.width() * 0.050,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.locationList[index]['title'],
                          style: textDesigner(23, DefaultTheme().whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
