import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/authentication_module/login/view/login_page.dart';
import 'package:solyticket/modules/booking_module/view/seat_selection_page.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/view/event_page.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/controller/customer_home_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/repo/customer_home_repo.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/view/widget/see_all_widget.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/view/widget/title_subtitle_widget.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/home/view/organizer_home_page.dart';
import 'package:solyticket/providers/api_client.dart';
import 'package:solyticket/utills/global.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/strings.dart';
import 'package:solyticket/utills/widget_formats.dart';
import 'package:solyticket/widgets/app_layout.dart';
import 'package:solyticket/widgets/appbar_logo.dart';
import 'package:solyticket/widgets/custom_elevated_button.dart';

class CustomerHomePage extends StatelessWidget {
  CustomerHomePage({super.key});

  final CustomerHomeController controller =
      Get.put(CustomerHomeController(CustomerHomeRepo(apiClient: ApiClient())));

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultAppLayout(
        isAppBar: true,
        title: Center(
          child: AppBarLogo().setLogo(),
        ),
        
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
          child: SizedBox(
            width: Media.width(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // verticalGap(20),
                _welcomeTitle(),
                verticalGap(25),
                headerBanner(),
                upcomingEvents(),
                entertainments(),
                hotEvents(),
                newEvents(),
                solyEvents(),
                locations()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _welcomeTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Solyticket'a Hoş Geldiniz",
          style: textDesigner(
            28,
            DefaultTheme().primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        // verticalGap(5),
        // Text(
        //   "",
        //   style: textDesigner(
        //     16,
        //     DefaultTheme().blackColor,
        //   ),
        // ),
      ],
    );
  }

  becomeMember() {
    return controller.recentEventList.value.data.isNotEmpty
        ? CustomElevatedButton(
            radius: 8,
            color: DefaultTheme().primaryColor,
            btnText: AppStrings.becomeMember,
            onTap: () async {
              Get.offAllNamed("registration");
            },
          )
        : SizedBox(
            width: Media.width(),
            height: 45,
            child: const CustomShimmer(height: 20, width: 75));
  }

  upcomingEventLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.upComingEvents,
          style: textDesigner(20, DefaultTheme().blackColor,
              fontWeight: FontWeight.bold),
        ),
        InkWell(
            onTap: () {
              Get.to(const EventPage(isFromTab: false));
            },
            child: const SeeAllButton()),
      ],
    );
  }

  eventLabelWithParam(text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: textDesigner(20, DefaultTheme().blackColor,
              fontWeight: FontWeight.bold),
        ),
        InkWell(
            onTap: () {
              Get.to(const EventPage(isFromTab: false));
            },
            child: const SeeAllButton()),
      ],
    );
  }

  discoverFunLabel() {
    return Text(
      AppStrings.discoverFun,
      style: textDesigner(
        15,
        DefaultTheme().blackColor,
      ),
    );
  }

  funLabelWithParams(text) {
    return Text(
      text,
      style: textDesigner(
        15,
        DefaultTheme().blackColor,
      ),
    );
  }

  upcomingEvents() {
    return controller.recentEventList.value.data.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalGap(25),
              funLabelWithParams("Hemen Yerini Ayırt!"),
              verticalGap(3),
              eventLabelWithParam("Yaklaşan Etkinlikler"),
              verticalGap(15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      controller.recentEventList.value.data.length,
                      (index) => InkWell(
                            onTap: () {
                              Get.toNamed("event-detail",
                                  arguments: controller
                                      .recentEventList.value.data[index].id);
                            },
                            child: Card(
                              child: Stack(
                                children: [
                                  Container(
                                    height: Media.height() * 0.2,
                                    width: Media.width(),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          AppConstants.imageBaseUrl +
                                              controller.recentEventList.value
                                                  .data[index].image,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: Media.height() * 0.1,
                                    left: Media.width() * 0.050,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.recentEventList.value
                                              .data[index].priceLabel,
                                          style: textDesigner(
                                            15,
                                            DefaultTheme().whiteColor,
                                          ),
                                        ),
                                        Text(
                                          controller.recentEventList.value
                                              .data[index].eventName,
                                          style: textDesigner(
                                            23,
                                            DefaultTheme().whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              DateFormat('MMM dd').format(
                                                  controller.recentEventList
                                                      .value.data[index].date),
                                              style: textDesigner(
                                                15,
                                                DefaultTheme().whiteColor,
                                              ),
                                            ),
                                            horizontalGap(10),
                                            Text(
                                              controller.recentEventList.value
                                                  .data[index].location.name,
                                              style: textDesigner(
                                                15,
                                                DefaultTheme().whiteColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                ),
              ),
            ],
          )
        : upcomingEventShimmer();
  }

  upcomingEventShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalGap(25),
        const CustomShimmer(height: 20, width: 75),
        verticalGap(10),
        const CustomShimmer(height: 20, width: 75),
        verticalGap(15),
        CustomShimmer(height: Media.height() * 0.2, width: Media.width()),
      ],
    );
  }

  entertainments() {
  Map<String, IconData> categoryIcons = {
    "Spor": Icons.sports_soccer,
    "Kültür Ve Sanat": Icons.palette,
    "Sahne": Icons.theater_comedy,
    "Müzik": Icons.music_note,
    "Eğitim": Icons.school,
  };

  return controller.catCountList.value.data.isNotEmpty
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalGap(40),
            TitleSubtitleText(
              title: AppStrings.discoverFun,
              subtitle: AppStrings.entertainmentGuide,
            ),
            verticalGap(20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Row(
                children: List.generate(
                  controller.catCountList.value.data.length,
                  (index) {
                    var category = controller.catCountList.value.data[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => EventPage(isFromTab: false),
                          arguments: {"initialCategoryId": category.id},
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                        child: SizedBox(
                          height: Media.height() * 0.18,
                          width: Media.width() * 0.4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  DefaultTheme().primaryColor.withOpacity(0.9),
                                  DefaultTheme().primaryColor.withOpacity(0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Icon(
                                    categoryIcons[category.categoryName] ??
                                        Icons.category,
                                    size: 70,
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.95),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 6,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Icon(
                                            categoryIcons[
                                                    category.categoryName] ??
                                                Icons.category,
                                            color: DefaultTheme().primaryColor,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                      verticalGap(10),
                                      Text(
                                        category.categoryName,
                                        style: textDesigner(
                                          16,
                                          Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      verticalGap(5),
                                      Text(
                                        "${category.count} Etkinlik",
                                        style: textDesigner(
                                          14,
                                          Colors.white.withOpacity(0.9),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )
      : catCountShimmer();
}


  catCountShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalGap(40),
        const CustomShimmer(height: 20, width: 75),
        verticalGap(20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                5,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CustomShimmer(
                          height: Media.height() * 0.150,
                          width: Media.width() * 0.3),
                    )),
          ),
        )
      ],
    );
  }

  discoverVanueLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            AppStrings.discoverVanue,
            style: textDesigner(20, DefaultTheme().blackColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        InkWell(
            onTap: () {
              controller.isFromTab.value = false;
              // Get.toNamed("location");
              Get.to(SeatSelectionPage());
            },
            child: const SeeAllButton()),
      ],
    );
  }

  disconverVanueList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: List.generate(
          controller.locationList.value.data.length,
          (index) => Card(
            elevation: 5,
            child: Stack(
              children: [
                Container(
                  height: Media.height() * 0.2,
                  width: Media.width() * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://ipfs.io/ipfs/QmR17RUjimQpqUz3mCJBdYgJWgvkpwRLcSzun87NDE6jrB"),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                    top: Media.height() * 0.120,
                    left: Media.width() * 0.050,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller
                              .locationList.value.data[index].locationName,
                          style: textDesigner(23, DefaultTheme().whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("",
                            // controller.locationList.value.data[index]
                            // ['subTitle'],
                            style: textDesigner(
                              15,
                              DefaultTheme().whiteColor,
                            )),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  hotEvents() {
    return controller.hotTicketList.value.data.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalGap(40),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const TitleSubtitleText(
                  title: "Keşfetmeye Hazır Mısın?",
                  subtitle: "Sıcak Biletler",
                ),
                InkWell(
                    onTap: () {
                      Get.to(const EventPage(isFromTab: false));
                    },
                    child: const SeeAllButton()),
              ]),
              verticalGap(15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: List.generate(
                      controller.hotTicketList.value.data.length, (index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed("event-detail",
                            arguments:
                                controller.hotTicketList.value.data[index].id);
                      },
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.only(right: 15, left: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Media.height() * 0.1,
                                horizontal: Media.width() * 0.3,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        AppConstants.imageBaseUrl +
                                            controller.hotTicketList.value
                                                .data[index].image,
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
                                            WidgetSpan(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Icon(
                                                    Icons.calendar_month,
                                                    color: DefaultTheme()
                                                        .primaryColor,
                                                    size: 16),
                                              ),
                                            ),
                                            TextSpan(
                                                text: DateFormat("yyyy-MM-dd")
                                                    .format(controller
                                                        .hotTicketList
                                                        .value
                                                        .data[index]
                                                        .date)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 10,
                                        color: DefaultTheme()
                                            .primaryColor
                                            .withOpacity(0.5),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 11),
                                          children: [
                                            WidgetSpan(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Icon(Icons.timer,
                                                    color: DefaultTheme()
                                                        .primaryColor,
                                                    size: 16),
                                              ),
                                            ),
                                            TextSpan(
                                                text: controller.hotTicketList
                                                    .value.data[index].time),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalGap(10),
                                  Text(
                                    controller.hotTicketList.value.data[index]
                                        .eventName,
                                    style: textDesigner(
                                        15, DefaultTheme().blackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  verticalGap(10),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 11),
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                              Icons.location_on_outlined,
                                              color:
                                                  DefaultTheme().primaryColor,
                                              size: 16),
                                        ),
                                        TextSpan(
                                            text: controller.hotTicketList.value
                                                .data[index].location.name),
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
              )
            ],
          )
        : recentEventShimmer();
  }

  newEvents() {
    return controller.newlySalesList.value.data.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalGap(40),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const TitleSubtitleText(
                  title: "Keşfetmeye Hazır Mısın?",
                  subtitle: "Sıcak Biletler",
                ),
                InkWell(
                    onTap: () {
                      Get.to(const EventPage(isFromTab: false));
                    },
                    child: const SeeAllButton()),
              ]),
              verticalGap(15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: List.generate(
                      controller.newlySalesList.value.data.length, (index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed("event-detail",
                            arguments:
                                controller.newlySalesList.value.data[index].id);
                      },
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.only(right: 15, left: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Media.height() * 0.1,
                                horizontal: Media.width() * 0.3,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        AppConstants.imageBaseUrl +
                                            controller.newlySalesList.value
                                                .data[index].image,
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
                                            WidgetSpan(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Icon(
                                                    Icons.calendar_month,
                                                    color: DefaultTheme()
                                                        .primaryColor,
                                                    size: 16),
                                              ),
                                            ),
                                            TextSpan(
                                                text: DateFormat("yyyy-MM-dd")
                                                    .format(controller
                                                        .newlySalesList
                                                        .value
                                                        .data[index]
                                                        .date)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 10,
                                        color: DefaultTheme()
                                            .primaryColor
                                            .withOpacity(0.5),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 11),
                                          children: [
                                            WidgetSpan(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Icon(Icons.timer,
                                                    color: DefaultTheme()
                                                        .primaryColor,
                                                    size: 16),
                                              ),
                                            ),
                                            TextSpan(
                                                text: controller.newlySalesList
                                                    .value.data[index].time),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalGap(10),
                                  Text(
                                    controller.newlySalesList.value.data[index]
                                        .eventName,
                                    style: textDesigner(
                                        15, DefaultTheme().blackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  verticalGap(10),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 11),
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                              Icons.location_on_outlined,
                                              color:
                                                  DefaultTheme().primaryColor,
                                              size: 16),
                                        ),
                                        TextSpan(
                                            text: controller
                                                .newlySalesList
                                                .value
                                                .data[index]
                                                .location
                                                .name),
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
              )
            ],
          )
        : recentEventShimmer();
  }

  solyEvents() {
    return controller.solyAdviceList.value.data.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalGap(40),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const TitleSubtitleText(
                  title: "Sizin İçin Seçtik",
                  subtitle: "SolyTicket Öneriyor",
                ),
                InkWell(
                    onTap: () {
                      Get.to(const EventPage(isFromTab: false));
                    },
                    child: const SeeAllButton()),
              ]),
              verticalGap(15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: List.generate(
                      controller.solyAdviceList.value.data.length, (index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed("event-detail",
                            arguments:
                                controller.solyAdviceList.value.data[index].id);
                      },
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.only(right: 15, left: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Media.height() * 0.1,
                                horizontal: Media.width() * 0.3,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        AppConstants.imageBaseUrl +
                                            controller.solyAdviceList.value
                                                .data[index].image,
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
                                            WidgetSpan(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Icon(
                                                    Icons.calendar_month,
                                                    color: DefaultTheme()
                                                        .primaryColor,
                                                    size: 16),
                                              ),
                                            ),
                                            TextSpan(
                                                text: DateFormat("yyyy-MM-dd")
                                                    .format(controller
                                                        .solyAdviceList
                                                        .value
                                                        .data[index]
                                                        .date)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 10,
                                        color: DefaultTheme()
                                            .primaryColor
                                            .withOpacity(0.5),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 11),
                                          children: [
                                            WidgetSpan(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Icon(Icons.timer,
                                                    color: DefaultTheme()
                                                        .primaryColor,
                                                    size: 16),
                                              ),
                                            ),
                                            TextSpan(
                                                text: controller.solyAdviceList
                                                    .value.data[index].time),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalGap(10),
                                  Text(
                                    controller.solyAdviceList.value.data[index]
                                        .eventName,
                                    style: textDesigner(
                                        15, DefaultTheme().blackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  verticalGap(10),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 11),
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                              Icons.location_on_outlined,
                                              color:
                                                  DefaultTheme().primaryColor,
                                              size: 16),
                                        ),
                                        TextSpan(
                                            text: controller
                                                .solyAdviceList
                                                .value
                                                .data[index]
                                                .location
                                                .name),
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
              )
            ],
          )
        : recentEventShimmer();
  }

  recentEventShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalGap(40),
        const CustomShimmer(height: 20, width: 75),
        verticalGap(15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                5,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CustomShimmer(
                          height: Media.height() * 0.25,
                          width: Media.width() * 0.50),
                    )),
          ),
        )
      ],
    );
  }

  locations() {
    return controller.locationList.value.data.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalGap(40),
              Text(
                AppStrings.discoverFun,
                style: textDesigner(
                  15,
                  DefaultTheme().blackColor,
                ),
              ),
              verticalGap(3),
              discoverVanueLabel(),
              verticalGap(15),
              disconverVanueList(),
              verticalGap(50),
            ],
          )
        : locationShimmer();
  }

  locationShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalGap(40),
        const CustomShimmer(height: 20, width: 75),
        verticalGap(10),
        const CustomShimmer(height: 20, width: 75),
        verticalGap(15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                5,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CustomShimmer(
                          height: Media.height() * 0.25, width: Media.width()),
                    )),
          ),
        ),
        verticalGap(50),
      ],
    );
  }

headerBanner() {
  return controller.highlightedEventList.value.data.isNotEmpty
      ? CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            height: Media.height() * 0.35,
          ),
          items: controller.highlightedEventList.value.data.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    "event-detail",
                    arguments: item.id,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        // Blurry Background
                        Positioned.fill(
                          child: ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Image.network(
                              AppConstants.imageBaseUrl + item.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: Colors.grey[300]),
                            ),
                          ),
                        ),
                        // Actual Image (Centered)
                        Positioned.fill(
                          child: Center(
                            child: Image.network(
                              AppConstants.imageBaseUrl + item.image,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        // Gradient Overlay for Text
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Event Details: Name and Location
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.eventName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textDesigner(
                                  20,
                                  Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.white, size: 16),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      item.location.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: textDesigner(
                                        14,
                                        Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        )
      : bannerShimmer();
}

  bannerShimmer() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        viewportFraction: 0.9,
        height: Media.height() * 0.35,
      ),
      items: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    DefaultTheme().primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
