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
        title: AppBarLogo().setLogo(),
        action: [
          GlobalClass.isLogin
              ? InkWell(
                  onTap: () async {
                   await GlobalClass().resetUserInfo();
                   Get.toNamed("login");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      AppStrings.logout,
                      style: textDesigner(
                        16,
                        fontWeight: FontWeight.w600,
                        DefaultTheme().primaryColor,
                      ),
                    ),
                  ),
                )
              : IconButton(
                  onPressed: () {
                    Get.toNamed("login");
                  },
                  icon: const Icon(Icons.lock))
        ],
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
          child: SizedBox(
            width: Media.width(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalGap(20),
                becomeMember(),
                verticalGap(25),
                headerBanner(),
                upcomingEvents(),
                entertainments(),
                recentEvents(),
                locations()
              ],
            ),
          ),
        ),
      ),
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

  discoverFunLabel() {
    return Text(
      AppStrings.discoverFun,
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
              discoverFunLabel(),
              verticalGap(3),
              upcomingEventLabel(),
              verticalGap(15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      controller.recentEventList.value.data.length,
                      (index) => InkWell(
                        onTap: (){
                          Get.toNamed("event-detail",arguments: controller.recentEventList.value.data[index].id);
                        },
                        child: Card(
                              child: Stack(
                                children: [
                                  Container(
                                    height: Media.height() * 0.2,
                                    width: Media.width(),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/upcoming_event_img.jpeg'),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Positioned(
                                      top: Media.height() * 0.1,
                                      left: Media.width() * 0.050,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('100-200',
                                              style: textDesigner(
                                                15,
                                                DefaultTheme().whiteColor,
                                              )),
                                          Text(
                                            controller.recentEventList.value
                                                .data[index].eventName,
                                            style: textDesigner(
                                                23, DefaultTheme().whiteColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('June 15',
                                                  style: textDesigner(
                                                    15,
                                                    DefaultTheme().whiteColor,
                                                  )),
                                              horizontalGap(10),
                                              Text(
                                                'Summer Beats',
                                                style: textDesigner(
                                                    15, DefaultTheme().whiteColor,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
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

  entertainments() {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      controller.catCountList.value.data.length,
                      (index) => SizedBox(
                            height: Media.height() * 0.150,
                            width: Media.width() * 0.3,
                            child: Card(
                              color: Colors.white,
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  verticalGap(5),
                                  Text(
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    controller.catCountList.value.data[index]
                                        .categoryName,
                                    style: textDesigner(
                                      18,
                                      DefaultTheme().blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  verticalGap(5),
                                  Text(
                                      "${controller.catCountList.value.data[index].count} Event"),
                                ],
                              ),
                            ),
                          )),
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

  recentEvents() {
    return controller.recentEventList.value.data.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalGap(40),
              TitleSubtitleText(
                title: AppStrings.discoverFun,
                subtitle: AppStrings.recentEvent,
              ),
              verticalGap(15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: List.generate(
                      controller.recentEventList.value.data.length, (index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed("event-detail",arguments: controller.recentEventList.value.data[index].id);
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
                                            controller.recentEventList.value
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
                                                        .recentEventList
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
                                                text: controller.recentEventList
                                                    .value.data[index].time),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalGap(10),
                                  Text(
                                    controller.recentEventList.value.data[index]
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
                                                .recentEventList
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
    return controller.upcomingEventList.value.data.isNotEmpty
        ? CarouselSlider(
            options: CarouselOptions(autoPlay: true, viewportFraction: 0.9),
            items: controller.upcomingEventList.value.data
                .map((item) => Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: Media.height() * 0.3,
                        width: Media.width() * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(
                                  AppConstants.imageBaseUrl + item.image),
                              fit: BoxFit.fill),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.eventName,
                              style: textDesigner(23, DefaultTheme().whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )))
                .toList(),
          )
        : bannerShimmer();
  }

  bannerShimmer() {
    return CarouselSlider(
      options: CarouselOptions(autoPlay: true, viewportFraction: 0.9),
      items: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomShimmer(
              height: Media.height() * 0.3,
              width: Media.width() * 0.8,
            ),
          ),
        )
      ],
    );
  }
}
