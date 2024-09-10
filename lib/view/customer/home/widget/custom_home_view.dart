import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:solyticket/components/custom_loader_button.dart';
import 'package:solyticket/constants/color_constant.dart';
import 'package:solyticket/controllers/home_controller.dart';
import 'package:solyticket/controllers/location_controller.dart';
import 'package:solyticket/model/event_detail_model.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/widget_formats.dart';
import 'package:solyticket/view/auth/regsiter_view.dart';
import 'package:solyticket/view/customer/events/event_detail_view.dart';
import 'package:solyticket/view/customer/events/event_view.dart';
import 'package:solyticket/view/customer/home/widget/title_subtitle_widget.dart';
import 'package:solyticket/view/customer/location/location_detail_view.dart';

class CustomerHomeView extends StatefulWidget {
  const CustomerHomeView({super.key});

  @override
  State<CustomerHomeView> createState() => _CustomerHomeViewState();
}

class _CustomerHomeViewState extends State<CustomerHomeView> {
  final HomeController homeController = Get.put(HomeController(), permanent: true);
  final LocationController locationController = Get.put(LocationController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
          child: SizedBox(
            width: Media.screenWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLoaderButton(
                  radius: 8,
                  color: primaryColor,
                  btnText: 'Become a Member',
                  onTap: () async {
                    Get.to(() => RegisterView());
                  },
                ),
                verticalGap(25),
                Text(
                  'NFT MEETS TICKETS!',
                  style: textDesigner(
                    20,
                    blackColor,
                  ),
                ),
                verticalGap(20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Discover Events ',
                          style: textDesigner(28, primaryColor,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: 'Around You',
                          style: textDesigner(28, blackColor,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                verticalGap(40),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Yes',
                        style: textDesigner(20, blackColor),
                      ),
                      verticalGap(10),
                      CustomDropdown<String>(
                        hintText: 'Select Event Type',
                        items: homeController.list,
                        onChanged: (value) {
                          log('changing value to: $value');
                        },
                      ),
                      verticalGap(20),
                      Text(
                        'Where',
                        style: textDesigner(20, blackColor),
                      ),
                      verticalGap(10),
                      CustomDropdown<String>(
                        hintText: 'Select City',
                        items: homeController.list,
                        onChanged: (value) {
                          log('changing value to: $value');
                        },
                      ),
                      verticalGap(30),
                      CustomLoaderButton(
                        radius: 8,
                        color: primaryColor,
                        btnText: 'We bug',
                        onTap: () async {},
                      ),
                      verticalGap(35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('1',
                                  style: textDesigner(23, blackColor,
                                      fontWeight: FontWeight.bold)),
                              const Text(
                                'Upcoming Evetns',
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('1',
                                  style: textDesigner(23, blackColor,
                                      fontWeight: FontWeight.bold)),
                              const Text('Tickets Sold'),
                            ],
                          ),
                          Column(
                            children: [
                              Text('9',
                                  style: textDesigner(23, blackColor,
                                      fontWeight: FontWeight.bold)),
                              const Text('Happy Customer'),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                verticalGap(40),
                Text(
                  'Discover the Fun!',
                  style: textDesigner(
                    15,
                    blackColor,
                  ),
                ),
                verticalGap(3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upcoming Events',
                      style: textDesigner(20, blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.to(() => const EventView(),
                                  transition: Transition.rightToLeft);
                            },
                            child: Text(
                              'See all',
                              style: textDesigner(
                                15,
                                primaryColor,
                              ),
                            )),
                        InkWell(
                          onTap: () {
                            Get.to(() => const EventView(),
                                transition: Transition.rightToLeft);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondaryColor,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalGap(15),
                Stack(
                  children: [
                    Container(
                      height: Media.screenHeight(context) * 0.2,
                      width: Media.screenWidth(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            image:
                                AssetImage('assets/images/upcoming_event_img.jpeg'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Positioned(
                        top: Media.screenHeight(context) * 0.1,
                        left: Media.screenWidth(context) * 0.050,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('100-200',
                                style: textDesigner(
                                  15,
                                  whiteColor,
                                )),
                            Text(
                              'Summer Beats',
                              style: textDesigner(23, whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('June 15',
                                    style: textDesigner(
                                      15,
                                      whiteColor,
                                    )),
                                horizontalGap(10),
                                Text(
                                  'Summer Beats',
                                  style: textDesigner(15, whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
                verticalGap(40),
                const TitleSubtitleText(
                  title: 'Discover the Fun!',
                  subtitle: 'Entertainment Guide',
                ),
                verticalGap(20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        homeController.entertainmentList.length,
                        (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              height: Media.screenHeight(context) * 0.150,
                              width: Media.screenWidth(context) * 0.3,
                              decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    homeController.entertainmentList[index]
                                        ['icon'],
                                    height: 30,
                                    width: 30,
                                  ),
                                  verticalGap(5),
                                  Text(
                                    homeController.entertainmentList[index]
                                        ['title'],
                                    style: textDesigner(18, blackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  verticalGap(5),
                                  Text(homeController.entertainmentList[index]
                                      ['countEvent']),
                                ],
                              ),
                            )),
                  ),
                ),
                verticalGap(40),
                const TitleSubtitleText(
                  title: 'Discover the Fun!',
                  subtitle: 'Recent Events',
                ),
                verticalGap(15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: List.generate(
                        homeController.eventDetailData.length, (index) {
                      return InkWell(
                        onTap: () {
                          EventDetailModel eventDetailModel =
                              homeController.eventDetailData[index];

                          Get.to(
                              () => EventDetailView(
                                  eventDetailModel: eventDetailModel),
                              transition: Transition.rightToLeft);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, left: 3),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: Media.screenHeight(context) * 0.1,
                                  horizontal: Media.screenWidth(context) * 0.3,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          homeController
                                              .eventDetailData[index].image!,
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 11),
                                            children: [
                                              const WidgetSpan(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  child: Icon(
                                                      Icons.calendar_month,
                                                      color: primaryColor,
                                                      size: 16),
                                                ),
                                              ),
                                              TextSpan(
                                                  text: homeController
                                                      .eventDetailData[index]
                                                      .date),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          height: 10,
                                          color: primaryColor.withOpacity(0.5),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 11),
                                            children: [
                                              const WidgetSpan(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  child: Icon(Icons.timer,
                                                      color: primaryColor,
                                                      size: 16),
                                                ),
                                              ),
                                              TextSpan(
                                                  text: homeController
                                                      .eventDetailData[index]
                                                      .time),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalGap(10),
                                    Text(
                                      homeController
                                          .eventDetailData[index].eventTitle!,
                                      style: textDesigner(15, blackColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    verticalGap(10),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 11),
                                        children: [
                                          const WidgetSpan(
                                            child: Icon(
                                                Icons.location_on_outlined,
                                                color: primaryColor,
                                                size: 16),
                                          ),
                                          TextSpan(
                                              text: homeController
                                                  .eventDetailData[index]
                                                  .location),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                verticalGap(40),
                Text(
                  'Discover the Fun!',
                  style: textDesigner(
                    15,
                    blackColor,
                  ),
                ),
                verticalGap(3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover Venues Around You',
                      style: textDesigner(20, blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.to(() => const LocationDetailView(),
                                  transition: Transition.rightToLeft);
                            },
                            child: Text(
                              'See all',
                              style: textDesigner(
                                15,
                                primaryColor,
                              ),
                            )),
                        InkWell(
                          onTap: () {
                            Get.to(() => const LocationDetailView(),
                                transition: Transition.rightToLeft);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondaryColor,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalGap(15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: List.generate(
                      locationController.locationList.length,
                      (index) => Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 12),
                            height: Media.screenHeight(context) * 0.2,
                            width: Media.screenWidth(context) * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage(locationController
                                      .locationList[index]['image']),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Positioned(
                              top: Media.screenHeight(context) * 0.120,
                              left: Media.screenWidth(context) * 0.050,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    locationController.locationList[index]
                                        ['title'],
                                    style: textDesigner(23, whiteColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      locationController.locationList[index]
                                          ['subTitle'],
                                      style: textDesigner(
                                        15,
                                        whiteColor,
                                      )),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                verticalGap(50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
