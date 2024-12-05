import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/extensions/date_extension.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/my_activity/controller/my_activity_controller.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/my_activity/repo/my_activity_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class MyActivityPage extends StatelessWidget {
  MyActivityPage({super.key});

  final MyActivityController myActivityController =
      Get.put(MyActivityController(MyActivityRepo(apiClient: ApiClient())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Image.asset('assets/images/logo.png',
            width: 40, height: 40, fit: BoxFit.cover),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: myActivityController.myActivityJson.value.data.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // EventDetailModel eventDetailModel =
                // controller.eventDetailData[index];
                // Get.to(
                //         () => EventDetailPage(
                //       eventDetailModel: eventDetailModel,
                //     ),
                //     transition: Transition.rightToLeft);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Card(
                      elevation: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.asset(
                                width: Get.width,
                                height: 150,
                                "assets/images/upcoming_event_img.jpeg",
                                fit: BoxFit.fitWidth,
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(
                                  myActivityController.myActivityJson.value.data[index].eventName,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5,),
                                Text("Total Ticket: ${myActivityController.myActivityJson.value.data[index].totalTickets}",
                                    style: TextStyle(
                                        color: Colors.blue[600],
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 2,),
                                Text("Sold Ticket : ${myActivityController.myActivityJson.value.data[index].soldTickets}",
                                    style: TextStyle(
                                        color: Colors.red[300],
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25,top: 60),
                        child: Container(
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                                textAlign: TextAlign.center,
                              text:  TextSpan(
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                children: [
                                  TextSpan(
                                      text: "${myActivityController.myActivityJson.value.data[index].date.getMonthShortName()}\n",style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  )),
                                  TextSpan(
                                      text: "${myActivityController.myActivityJson.value.data[index].date.getDay()}\n",style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  )),
                                  TextSpan(
                                      text: myActivityController.myActivityJson.value.data[index].date.getYear(),style: const TextStyle(
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
              ),
            );
          }),
    );
  }
}
