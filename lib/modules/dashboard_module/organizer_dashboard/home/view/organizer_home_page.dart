import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solyticket/extensions/date_extension.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/home/controller/organizer_home_controller.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/home/repo/organizer_home_repo.dart';
import 'package:solyticket/providers/api_client.dart';
import 'package:solyticket/utills/snippets.dart';

class OrganizerHomePage extends StatelessWidget {
  OrganizerHomePage({super.key});

  final OrganizerHomeController controller = Get.put(
      OrganizerHomeController(OrganizerHomeRepo(apiClient: ApiClient())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Image.asset('assets/images/logo.png',
            width: 40, height: 40, fit: BoxFit.cover),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalGap(10),
                welcomeTitle(),
                verticalGap(25),
                statisticInfo(),
                verticalGap(25),
                profileInfoCard(),
                verticalGap(25),
                recentEvents()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerCards(
      String title, String data, Color startColor, Color endColor) {
    return Flexible(
      flex: 1,
      child: Card(
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                startColor,
                endColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  textAlign: TextAlign.center,
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                height: 0.7,
                width: 12,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  data,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileInfoCard() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !controller.isLoading.value
                ? RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                            text: "Profile",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                            text: " Details",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                  )
                : const CustomShimmer(height: 20, width: 75),
            verticalGap(10),
            !controller.isLoading.value
                ? Card(
                    elevation: 8,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          personalInfo(
                              Icons.email_outlined,
                              controller
                                  .organizerHomeData.value.data!.profile.email),
                          verticalGap(5),
                          personalInfo(
                              Icons.phone,
                              controller
                                  .organizerHomeData.value.data!.profile.phone),
                        ],
                      ),
                    ),
                  )
                : CustomShimmer(height: 70, width: Get.width),
          ],
        ));
  }

  Widget welcomeTitle() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !controller.isLoading.value
                ? const Text(
                    "Welcome Back,",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700),
                  )
                : const CustomShimmer(height: 10, width: 80),
            verticalGap(5),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: !controller.isLoading.value
                  ? Text(
                      controller.organizerHomeData.value.data!.profile.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  : const CustomShimmer(height: 20, width: 40),
            ),
          ],
        ));
  }

  personalInfo(IconData icon, String data) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey.shade600,
          size: 18,
        ),
        horizontalGap(10),
        Text(
          data,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        )
      ],
    );
  }

  statisticInfo() {
    return Obx(() => Row(
          children: [
            !controller.isLoading.value
                ? headerCards(
                    "Total Events",
                    controller.organizerHomeData.value.data!.totalEvents
                        .toString(),
                    Colors.blue.shade500,
                    Colors.blue.shade100)
                : const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CustomShimmer(height: 110, width: 100)),
            !controller.isLoading.value
                ? headerCards(
                    "Total Earnings",
                    controller.organizerHomeData.value.data!.totalEarnings
                        .toString(),
                    Colors.orange.shade500,
                    Colors.orange.shade100)
                : const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CustomShimmer(height: 110, width: 100)),
            !controller.isLoading.value
                ? headerCards(
                    "Total Active Ads",
                    controller.organizerHomeData.value.data!.activeAds
                        .toString(),
                    Colors.purple.shade500,
                    Colors.purple.shade100)
                : const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CustomShimmer(height: 110, width: 100)),
          ],
        ));
  }

  recentEvents() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !controller.isLoading.value
                ? RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                            text: "Recent",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                            text: " Event",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                  )
                : const CustomShimmer(height: 20, width: 75),
            verticalGap(10),
            !controller.isLoading.value
                ? Card(
                    elevation: 8,
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Container(
                          height: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 70.0),
                            child: Text(
                              controller.organizerHomeData.value.data!
                                  .mostRecentEvent.eventName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0, top: 0),
                            child: Container(
                              width: 60,
                              height: 75,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    children: [
                                      TextSpan(
                                          text:
                                              "${controller.organizerHomeData.value.data!.mostRecentEvent.date.getMonthShortName()}\n",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      TextSpan(
                                          text:
                                              "${controller.organizerHomeData.value.data!.mostRecentEvent.date.getDay()}\n",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      TextSpan(
                                          text: controller.organizerHomeData
                                              .value.data!.mostRecentEvent.date
                                              .getYear()
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  )
                : CustomShimmer(height: 70, width: Get.width),
          ],
        ));
  }
}

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;

  const CustomShimmer({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: const Card(
          elevation: 5,
        ),
      ),
    );
  }
}
