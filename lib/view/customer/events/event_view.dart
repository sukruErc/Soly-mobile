import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/components/common_function.dart';
import 'package:solyticket/constants/color_constant.dart';
import 'package:solyticket/controllers/home_controller.dart';
import 'package:solyticket/model/event_detail_model.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/widget_formats.dart';
import 'package:solyticket/view/customer/events/event_detail_view.dart';

import '../../../utills/media.dart';

class EventView extends StatefulWidget {
  const EventView({
    super.key,
  });

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            padding: const EdgeInsets.only(right: 3),
            onPressed: () {
              Get.back();

              setState(() {});
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 22,
            )),
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text(
          'Events',
          style: textDesigner(23, primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: homeController.eventDetailData.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                EventDetailModel eventDetailModel =
                    homeController.eventDetailData[index];
                Get.to(
                    () => EventDetailView(
                          eventDetailModel: eventDetailModel,
                        ),
                    transition: Transition.rightToLeft);
              },
              child: Container(
                height: Media.screenHeight(context) * 0.160,
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Media.screenHeight(context) * 0.080,
                        horizontal: Media.screenWidth(context) * 0.150,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: AssetImage(
                                homeController.eventDetailData[index].image!,
                              ),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  children: [
                                    const WidgetSpan(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(Icons.calendar_month,
                                            color: primaryColor, size: 18),
                                      ),
                                    ),
                                    TextSpan(
                                        text: homeController
                                            .eventDetailData[index].date),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 15,
                                color: primaryColor.withOpacity(0.5),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  children: [
                                    const WidgetSpan(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(Icons.timer,
                                            color: primaryColor, size: 18),
                                      ),
                                    ),
                                    TextSpan(
                                        text: homeController
                                            .eventDetailData[index].time),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          verticalGap(12),
                          Text(
                            homeController.eventDetailData[index].eventTitle!,
                            style: textDesigner(18, blackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          verticalGap(12),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              children: [
                                const WidgetSpan(
                                  child: Icon(Icons.location_on_outlined,
                                      color: primaryColor, size: 18),
                                ),
                                TextSpan(
                                    text: homeController
                                        .eventDetailData[index].location),
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
    );
  }
}
