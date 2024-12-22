import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/dashboard/controller/customer_dashboard_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/view/event_page.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/view/customer_home_page.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/collection/view/collection_page.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/profile/view/profile_page.dart';
import 'package:solyticket/utills/images.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class CustomerDashboardPage extends GetView<CustomerDashboardController> {
  const CustomerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: DefaultTheme().backgroundColor,
        body: PageView(
          controller: controller.bottomController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            controller.bottomSelectedIndex.value = value;
            controller.bottomController.jumpToPage(value);
          },
          children: [
            CustomerHomePage(),
            const EventPage(isFromTab: true),
            const SizedBox(),
            CollectionPage(),
            ProfilePage(),
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
                icon: const Icon(Icons.house_outlined),
                selectedIcon: const Icon(Icons.house_rounded),
                selectedColor: DefaultTheme().primaryColor,
                unSelectedColor: DefaultTheme().greyColor,
                title: const Text('Ana Sayfa'),
              ),
              BottomBarItem(
                icon: const Icon(Icons.search),
                selectedIcon: const Icon(Icons.search),
                selectedColor: DefaultTheme().primaryColor,
                unSelectedColor: DefaultTheme().greyColor,
                title: const Text('Etkinlikler'),
              ),
              BottomBarItem(
                icon: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.logo,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                selectedIcon: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.logo,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                selectedColor: Colors.transparent,
                unSelectedColor: Colors.transparent,
                title: const SizedBox.shrink(),
              ),
              BottomBarItem(
                icon: const Icon(Icons.collections_bookmark_outlined),
                selectedIcon: const Icon(Icons.collections_bookmark),
                selectedColor: DefaultTheme().primaryColor,
                unSelectedColor: DefaultTheme().greyColor,
                title: const Text('Koleksiyon'),
              ),
              BottomBarItem(
                icon: const Icon(Icons.person_outline),
                selectedIcon: const Icon(Icons.person),
                selectedColor: DefaultTheme().primaryColor,
                unSelectedColor: DefaultTheme().greyColor,
                title: const Text('Profil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
