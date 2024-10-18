import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/dashboard/controller/organizer_dashboard_controller.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/home/view/organizer_home_page.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/my_activity/view/my_activity_page.dart';
import 'package:solyticket/utills/images.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class OrganizerDashboardPage extends GetView<OrganizerDashboardController> {
  const OrganizerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      backgroundColor: DefaultTheme().backgroundColor,
      body: PageView(
        controller: controller.bottomController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          // homeController.isFromTab.value = true;
          controller.bottomSelectedIndex.value = value;
          controller.bottomController.jumpToPage(value);
        },
        children: [
          OrganizerHomePage(),
          SizedBox(),
          MyActivityPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: DefaultTheme().whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: StylishBottomBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            option: AnimatedBarOptions(
              inkEffect: false,
              barAnimation: BarAnimation.fade,
              padding: const EdgeInsets.all(5),
              iconStyle: IconStyle.animated,
              opacity: 0.5,
            ),
            hasNotch: true,
            fabLocation: StylishBarFabLocation.center,
            currentIndex: controller.bottomSelectedIndex.value,
            onTap: (index) {
              controller.bottomSelectedIndex.value = index;
              controller.bottomController.jumpToPage(index);
            },
            items: [
              BottomBarItem(
                icon: const Icon(
                  Icons.house_outlined,
                ),
                selectedIcon: const Icon(Icons.house_rounded),
                selectedColor: DefaultTheme().primaryColor,
                unSelectedColor: DefaultTheme().greyColor,
                title: const Text('Home'),
              ),
              BottomBarItem(icon: const SizedBox(), title: const SizedBox()),
              BottomBarItem(
                icon: const Icon(Icons.event),
                selectedIcon: const Icon(
                  Icons.event,
                ),
                selectedColor: DefaultTheme().primaryColor,
                unSelectedColor: DefaultTheme().greyColor,
                title: const Text('Activity'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black26)),
          padding: const EdgeInsets.all(1),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FloatingActionButton(
              onPressed: () async {},
              backgroundColor: DefaultTheme().whiteColor,
              child: Image.asset(
                AppImages.logo,
                height: 60,
                width: 60,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }
}
