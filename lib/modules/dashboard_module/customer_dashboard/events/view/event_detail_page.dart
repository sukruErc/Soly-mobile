import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/controller/event_detail_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/repo/event_detail_repo.dart';
import 'package:solyticket/providers/api_client.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/strings.dart';
import 'package:solyticket/utills/widget_formats.dart';
import 'package:solyticket/widgets/app_layout.dart';

class EventDetailPage extends StatelessWidget {
  EventDetailPage({super.key});

  final eventDetailController = Get.put(
      EventDetailController(EventDetailRepo(apiClient: ApiClient()), Get.arguments));
  @override
  Widget build(BuildContext context) {
    return DefaultAppLayout(
      leading: showBackButton(),
     title: showAppBarTitle(),
     centerTitle: true,
     isAppBar: true,
     child: Obx(()=>eventDetailController.eventDetail.value.data!=null?SingleChildScrollView(
       padding: const EdgeInsets.all(12),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(
             eventDetailController.eventDetail.value.data!.eventName,
             style: textDesigner(23, DefaultTheme().blackColor, fontWeight: FontWeight.bold),
           ),
           verticalGap(10),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               RichText(
                 text: TextSpan(
                   style: const TextStyle(color: Colors.black, fontSize: 15),
                   children: [
                     WidgetSpan(
                       child: Icon(Icons.calendar_month,
                           color: DefaultTheme().primaryColor, size: 20),
                     ),
                     TextSpan(text: DateFormat("yyyy-MM-dd")
                         .format(eventDetailController.eventDetail.value.data!.date)),
                   ],
                 ),
               ),
               horizontalGap(3),
               Container(
                 width: 1,
                 height: 10,
                 color: DefaultTheme().primaryColor.withOpacity(0.5),
                 margin: const EdgeInsets.symmetric(horizontal: 10),
               ),
               horizontalGap(3),
               RichText(
                 text: TextSpan(
                   style: const TextStyle(color: Colors.black, fontSize: 15),
                   children: [
                     WidgetSpan(
                       child: Icon(Icons.timer, color: DefaultTheme().primaryColor, size: 20),
                     ),
                     TextSpan(text: eventDetailController.eventDetail.value.data!.time),
                   ],
                 ),
               ),
               horizontalGap(70),
               Flexible(
                 child: RichText(
                   textAlign: TextAlign.center,
                   text: TextSpan(
                     style: const TextStyle(color: Colors.black, fontSize: 15),
                     children: [
                       WidgetSpan(
                         child: Icon(Icons.location_on_outlined,
                             color: DefaultTheme().primaryColor, size: 20),
                       ),
                       TextSpan(text: eventDetailController.eventDetail.value.data!.location.name),
                     ],
                   ),
                 ),
               ),
             ],
           ),
           verticalGap(20),
           Container(
             height: Media.height() * 0.3,
             width: Media.width(),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               image: DecorationImage(
                   image: NetworkImage(AppConstants.imageBaseUrl+eventDetailController.eventDetail.value.data!.image),
                   fit: BoxFit.cover),
             ),
           ),
           verticalGap(15),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               RichText(
                 text: TextSpan(
                   style: TextStyle(
                       color: DefaultTheme().primaryColor,
                       fontSize: 20,
                       fontWeight: FontWeight.bold),
                   children: [
                     TextSpan(text: '${eventDetailController.eventDetail.value.data!.priceLabel}₺'),
                   ],
                 ),
               ),
               GestureDetector(
                 onTap: ()=>Get.toNamed("seat-category-selection",arguments: [eventDetailController.eventDetail.value.data!.id]),
                 child: Container(
                   padding:
                   const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                   decoration: BoxDecoration(
                     color: DefaultTheme().primaryColor,
                     borderRadius: BorderRadius.circular(5),
                   ),
                   child: Text(
                     'Buy now',
                     style: textDesigner(12,DefaultTheme().whiteColor),
                   ),
                 ),
               )
             ],
           ),
           verticalGap(15),
           Text(
             eventDetailController.eventDetail.value.data!.eventName,
             style: textDesigner(15, DefaultTheme().blackColor, fontWeight: FontWeight.bold),
           ),
           const Text("Subtitle"),
           verticalGap(15),
           Text(
             'Organizer',
             style: textDesigner(15, DefaultTheme().blackColor, fontWeight: FontWeight.bold),
           ),
           verticalGap(15),
           Container(
             height: Media.height() * 0.1,
             width: Media.width(),
             padding: const EdgeInsets.all(12),
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: DefaultTheme().whiteColor,
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
                       "Organizer",
                       style: textDesigner(14, DefaultTheme().blackColor,
                           fontWeight: FontWeight.bold),
                     ),
                     Text(
                       'Joined since "member date?"',
                       style: textDesigner(
                         10.5,
                         DefaultTheme().blackColor,
                       ),
                     ),
                     RichText(
                       text: TextSpan(
                         style: const TextStyle(
                             color: Colors.black, fontSize: 12),
                         children: [
                           WidgetSpan(
                             child: Icon(Icons.location_on_outlined,
                                 color: DefaultTheme().primaryColor, size: 15),
                           ),
                           TextSpan(text: eventDetailController.eventDetail.value.data!.location.name),
                         ],
                       ),
                     ),
                   ],
                 ),
                 Flexible(
                   child: Container(
                     padding: const EdgeInsets.symmetric(
                         horizontal: 30, vertical: 10),
                     decoration: BoxDecoration(
                       color: DefaultTheme().primaryColor,
                       borderRadius: BorderRadius.circular(5),
                     ),
                     child: Text(
                       'View Other Activities',
                       style: textDesigner(11, DefaultTheme().whiteColor),
                     ),
                   ),
                 )
               ],
             ),
           ),
           verticalGap(25),
           Text(
             'Similar Events',
             style: textDesigner(15, DefaultTheme().blackColor, fontWeight: FontWeight.bold),
           ),
           verticalGap(15),
           // SingleChildScrollView(
           //   scrollDirection: Axis.horizontal,
           //   physics: const AlwaysScrollableScrollPhysics(),
           //   padding: const EdgeInsets.symmetric(vertical: 8),
           //   child: Row(
           //     children: List.generate(homeController.eventDetailData.length,
           //             (index) {
           //           String widgetTitle = widget.eventDetailModel!.eventTitle!;
           //           String eventDataTitle =
           //           homeController.eventDetailData[index].eventTitle!;
           //
           //           // Check if the titles are an exact match
           //           bool isExactMatch = widgetTitle == eventDataTitle;
           //
           //           bool hasPartialMatch = !isExactMatch &&
           //               eventDataTitle.split(' ').any(
           //                       (word) =>
           //                       eventDataTitle.split(' ').contains(word));
           //
           //           return hasPartialMatch
           //               ? Container(
           //             margin: const EdgeInsets.only(right: 15, left: 3),
           //             decoration: BoxDecoration(
           //               color: DefaultTheme().whiteColor,
           //               borderRadius: BorderRadius.circular(12),
           //               boxShadow: [
           //                 BoxShadow(
           //                   color: Colors.grey.withOpacity(0.5),
           //                   spreadRadius: 2,
           //                   blurRadius: 2,
           //                   offset: const Offset(0, 2),
           //                 ),
           //               ],
           //             ),
           //             child: Column(
           //               crossAxisAlignment: CrossAxisAlignment.start,
           //               children: [
           //                 Container(
           //                   padding: EdgeInsets.symmetric(
           //                     vertical: Media.height() * 0.1,
           //                     horizontal: Media.width() * 0.3,
           //                   ),
           //                   decoration: BoxDecoration(
           //                       borderRadius: const BorderRadius.only(
           //                           topLeft: Radius.circular(10),
           //                           topRight: Radius.circular(10)),
           //                       image: DecorationImage(
           //                           image: AssetImage(
           //                             homeController
           //                                 .eventDetailData[index].image!,
           //                           ),
           //                           fit: BoxFit.cover)),
           //                 ),
           //                 Padding(
           //                   padding: const EdgeInsets.all(12),
           //                   child: Column(
           //                     crossAxisAlignment: CrossAxisAlignment.start,
           //                     children: [
           //                       Row(
           //                         children: [
           //                           RichText(
           //                             text: TextSpan(
           //                               style: const TextStyle(
           //                                   color: Colors.black,
           //                                   fontSize: 11),
           //                               children: [
           //                                  WidgetSpan(
           //                                   child: Padding(
           //                                     padding:
           //                                     EdgeInsets.only(right: 5),
           //                                     child: Icon(
           //                                         Icons.calendar_month,
           //                                         color: DefaultTheme().primaryColor,
           //                                         size: 16),
           //                                   ),
           //                                 ),
           //                                 TextSpan(
           //                                     text: homeController
           //                                         .eventDetailData[index]
           //                                         .date),
           //                               ],
           //                             ),
           //                           ),
           //                           Container(
           //                             width: 1,
           //                             height: 10,
           //                             color: DefaultTheme().primaryColor.withOpacity(0.5),
           //                             margin: const EdgeInsets.symmetric(
           //                                 horizontal: 10),
           //                           ),
           //                           RichText(
           //                             text: TextSpan(
           //                               style: const TextStyle(
           //                                   color: Colors.black,
           //                                   fontSize: 11),
           //                               children: [
           //                                  WidgetSpan(
           //                                   child: Padding(
           //                                     padding:
           //                                     EdgeInsets.only(right: 5),
           //                                     child: Icon(Icons.timer,
           //                                         color: DefaultTheme().primaryColor,
           //                                         size: 16),
           //                                   ),
           //                                 ),
           //                                 TextSpan(
           //                                     text: homeController
           //                                         .eventDetailData[index]
           //                                         .time),
           //                               ],
           //                             ),
           //                           ),
           //                         ],
           //                       ),
           //                       verticalGap(10),
           //                       Text(
           //                         homeController
           //                             .eventDetailData[index].eventTitle!,
           //                         style: textDesigner(15, DefaultTheme().blackColor,
           //                             fontWeight: FontWeight.bold),
           //                       ),
           //                       verticalGap(10),
           //                       RichText(
           //                         text: TextSpan(
           //                           style: const TextStyle(
           //                               color: Colors.black, fontSize: 11),
           //                           children: [
           //                              WidgetSpan(
           //                               child: Icon(
           //                                   Icons.location_on_outlined,
           //                                   color: DefaultTheme().primaryColor,
           //                                   size: 16),
           //                             ),
           //                             TextSpan(
           //                                 text: homeController
           //                                     .eventDetailData[index]
           //                                     .location),
           //                           ],
           //                         ),
           //                       ),
           //                     ],
           //                   ),
           //                 ),
           //               ],
           //             ),
           //           )
           //               : const SizedBox();
           //         }),
           //   ),
           // ),
         ],
       ),
     ):const Center(child: CircularProgressIndicator(),)),
    );
  }

  showBackButton() {
    return IconButton(
        padding: const EdgeInsets.only(right: 3),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 22,
        ));
  }

  showAppBarTitle() {
    return Text(
      AppStrings.eventDetailTitle,
      style: textDesigner(23, DefaultTheme().primaryColor,
          fontWeight: FontWeight.bold),
    );
  }
}
