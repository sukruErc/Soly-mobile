import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/color_constant.dart';
import 'package:solyticket/controllers/location_controller.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/widget_formats.dart';

class LocationDetailView extends StatefulWidget {
  const LocationDetailView({super.key});

  @override
  State<LocationDetailView> createState() => _LocationDetailViewState();
}

class _LocationDetailViewState extends State<LocationDetailView> {
  LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
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
          backgroundColor: backgroundColor,
          centerTitle: true,
          title: Text(
            'Events Location',
            style: textDesigner(23, primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: locationController.locationList.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  height: Media.screenHeight(context) * 0.170,
                  width: Media.screenWidth(context) * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: AssetImage(
                            locationController.locationList[index]['image']),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                    top: Media.screenHeight(context) * 0.140,
                    left: Media.screenWidth(context) * 0.050,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locationController.locationList[index]['title'],
                          style: textDesigner(23, whiteColor,
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
