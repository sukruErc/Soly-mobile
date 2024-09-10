import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/components/common_function.dart';
import 'package:solyticket/constants/asset_constant.dart';
import 'package:solyticket/constants/color_constant.dart';
import 'package:solyticket/view/auth/profile.dart';
import 'package:solyticket/view/customer/events/event_view.dart';
import 'package:solyticket/view/customer/home/widget/custom_home_view.dart';
import 'package:solyticket/view/customer/location/location_detail_view.dart';

import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class CustomerDashboardView extends StatefulWidget {
  const CustomerDashboardView({
    super.key,
  });

  @override
  State<CustomerDashboardView> createState() => _CustomerDashboardViewState();
}

class _CustomerDashboardViewState extends State<CustomerDashboardView> {
  
  @override
  void initState() {
    super.initState();
    bottomController = PageController(initialPage: bottomSelectedIndex.value);
  }

  @override
  void dispose() {
    bottomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: backgroundColor,
        body: PageView(
          controller: bottomController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            bottomSelectedIndex.value = value;
            bottomController.jumpToPage(value);
            setState(() {
              
            });
          },
          children: const [
            CustomerHomeView(),
            EventView(),
            SizedBox(),
            LocationDetailView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: whiteColor,
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
              currentIndex: bottomSelectedIndex.value,
              onTap: (index) {
                
                bottomSelectedIndex.value = index;
                bottomController.jumpToPage(index);
               
                setState(() {});
              },
              items: [
                BottomBarItem(
                  icon: const Icon(
                    Icons.house_outlined,
                  ),
                  selectedIcon: const Icon(Icons.house_rounded),
                  selectedColor: primaryColor,
                  unSelectedColor: greyColor,
                  title: const Text('Home'),
                ),
                BottomBarItem(
                  icon: const Icon(Icons.event),
                  selectedIcon: const Icon(
                    Icons.event,
                  ),
                  selectedColor: primaryColor,
                  unSelectedColor: greyColor,
                  title: const Text('Events'),
                ),
                BottomBarItem(icon: const SizedBox(), title: const SizedBox()),
                BottomBarItem(
                    icon: const Icon(
                      Icons.location_on,
                    ),
                    selectedIcon: const Icon(
                      Icons.location_on,
                    ),
                    selectedColor: primaryColor,
                    unSelectedColor: greyColor,
                    title: const Text('Location')),
                BottomBarItem(
                    icon: const Icon(
                      Icons.person_outline,
                    ),
                    selectedIcon: const Icon(
                      Icons.person,
                    ),
                    selectedColor: primaryColor,
                    unSelectedColor: greyColor,
                    title: const Text('Profile')),
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
                backgroundColor: whiteColor,
                child: Image.asset(
                  SolyTicketAsset.solyTicket,
                  height: 60,
                  width: 60,
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
