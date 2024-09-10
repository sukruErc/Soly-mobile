import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/color_constant.dart';
import 'package:solyticket/controllers/home_controller.dart';
import 'package:solyticket/model/event_detail_model.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/widget_formats.dart';

class EventDetailView extends StatefulWidget {
  const EventDetailView({super.key, this.eventDetailModel});

  final EventDetailModel? eventDetailModel;

  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Event Detail ',
          style: textDesigner(23, primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.eventDetailModel!.eventTitle!,
              style: textDesigner(23, blackColor, fontWeight: FontWeight.bold),
            ),
            verticalGap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    children: [
                      const WidgetSpan(
                        child: Icon(Icons.calendar_month,
                            color: primaryColor, size: 20),
                      ),
                      TextSpan(text: widget.eventDetailModel!.date),
                    ],
                  ),
                ),
                horizontalGap(3),
                Container(
                  width: 1,
                  height: 10,
                  color: primaryColor.withOpacity(0.5),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                horizontalGap(3),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    children: [
                      const WidgetSpan(
                        child: Icon(Icons.timer, color: primaryColor, size: 20),
                      ),
                      TextSpan(text: widget.eventDetailModel!.time),
                    ],
                  ),
                ),
                horizontalGap(70),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    children: [
                      const WidgetSpan(
                        child: Icon(Icons.location_on_outlined,
                            color: primaryColor, size: 20),
                      ),
                      TextSpan(text: widget.eventDetailModel!.location),
                    ],
                  ),
                ),
              ],
            ),
            verticalGap(20),
            Container(
              height: Media.screenHeight(context) * 0.3,
              width: Media.screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(widget.eventDetailModel!.image!),
                    fit: BoxFit.cover),
              ),
            ),
            verticalGap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: '${widget.eventDetailModel!.price}₺'),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Buy now',
                    style: textDesigner(12, whiteColor),
                  ),
                )
              ],
            ),
            verticalGap(15),
            Text(
              widget.eventDetailModel!.eventTitle!,
              style: textDesigner(15, blackColor, fontWeight: FontWeight.bold),
            ),
            Text(widget.eventDetailModel!.eventSubTitle!),
            verticalGap(15),
            Text(
              'Organizer',
              style: textDesigner(15, blackColor, fontWeight: FontWeight.bold),
            ),
            verticalGap(15),
            Container(
              height: Media.screenHeight(context) * 0.1,
              width: Media.screenWidth(context),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.eventDetailModel!.organizer!,
                        style: textDesigner(14, blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Joined since ${widget.eventDetailModel!.memberDate}',
                        style: textDesigner(
                          10.5,
                          blackColor,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                          children: [
                            const WidgetSpan(
                              child: Icon(Icons.location_on_outlined,
                                  color: primaryColor, size: 15),
                            ),
                            TextSpan(text: widget.eventDetailModel!.location),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'View Other Activities',
                      style: textDesigner(12, whiteColor),
                    ),
                  )
                ],
              ),
            ),
            verticalGap(25),
            Text(
              'Similar Events',
              style: textDesigner(15, blackColor, fontWeight: FontWeight.bold),
            ),
            verticalGap(15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: List.generate(homeController.eventDetailData.length,
                    (index) {
                  String widgetTitle = widget.eventDetailModel!.eventTitle!;
                  String eventDataTitle =
                      homeController.eventDetailData[index].eventTitle!;

                  // Check if the titles are an exact match
                  bool isExactMatch = widgetTitle == eventDataTitle;

                  bool hasPartialMatch = !isExactMatch &&
                      eventDataTitle.split(' ').any(
                          (word) => eventDataTitle.split(' ').contains(word));

                  return hasPartialMatch
                      ? Container(
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
                        )
                      : const SizedBox();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
