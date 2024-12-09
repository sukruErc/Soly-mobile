import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/controller/event_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/repo/event_repo.dart';
import 'package:solyticket/providers/api_client.dart';
import 'package:solyticket/utills/media.dart';
import 'package:solyticket/utills/snippets.dart';
import 'package:solyticket/utills/strings.dart';
import 'package:solyticket/utills/widget_formats.dart';
import 'package:solyticket/widgets/app_layout.dart';
import 'package:solyticket/widgets/custom_text_form_field.dart';

class EventPage extends StatefulWidget {
  final bool isFromTab;

   const EventPage({super.key, required this.isFromTab});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late EventController controller;
  @override
  void initState() {
    controller =
        Get.put(EventController(EventRepo(apiClient: ApiClient()),widget.isFromTab));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultAppLayout(
          centerTitle: true,
          isAppBar: true,
          leading: backButton(),
          title: title(),
          action: setAction(),
          child: controller.isSearchLoading.value
              ? const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.eventSearchJson.value.data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        eventDetail(controller.eventSearchJson.value.data[index].id);
                      },
                      child: eventListItems(index),
                    );
                  }),
        ));
  }

  showFilter() {
    Get.bottomSheet(Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filters",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "Close",
                      style: textDesigner(
                        14,
                        DefaultTheme().primaryColor,
                      ),
                    ))
              ],
            ),
          ),
          Divider(
            height: 0.2,
            color: Colors.grey[300],
          ),
          verticalGap(15),
          // Container(
          //   height: 60,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: ListView(scrollDirection: Axis.horizontal,children: [
          //       Chip(
          //         label: const Text(
          //             "Developer",
          //             style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400)),
          //         elevation: 0,
          //         backgroundColor: Colors.blue.withOpacity(0.8),
          //         side: const BorderSide(width: 0),
          //         deleteIconColor: Colors.white,
          //         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
          //         onDeleted: () {
          //           // filterController.removeSelectedChip(index);
          //         },
          //         deleteIcon: Icon(
          //           Icons.close,
          //           size: 20,
          //         ),
          //       ),
          //       horizontalGap(10),
          //       Chip(
          //         label: const Text(
          //             "Consultant",
          //             style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400)),
          //         elevation: 0,
          //         backgroundColor: Colors.blue.withOpacity(0.8),
          //         side: const BorderSide(width: 0),
          //         deleteIconColor: Colors.white,
          //         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
          //         onDeleted: () {
          //           // filterController.removeSelectedChip(index);
          //         },
          //         deleteIcon: Icon(
          //           Icons.close,
          //           size: 20,
          //         ),
          //       ),
          //     ],),
          //   ),
          // ),
          // verticalGap(15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
              maxLine: 1,
              labelText: '',
              hintText: 'Select Date',
              controller: controller.textEditingController,
              suffixIcon: Icons.date_range,
              fillerColor: Colors.white,
              isLabel: false,
              onTap: () {
                selectDate(context);
              },
              focusNode: AlwaysDisabledFocusNode(),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: CustomDropdown<String>(
          //     hintText: 'Select',
          //     decoration: CustomDropdownDecoration(
          //         closedBorder: Border.all(color: textFieldColor)),
          //     items: list,
          //     onChanged: (value) {
          //       log('changing value to: $value');
          //     },
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: CustomDropdown<String>(
          //     hintText: 'Select',
          //     decoration: CustomDropdownDecoration(
          //         closedBorder: Border.all(color: textFieldColor)),
          //     items: controller.list,
          //     onChanged: (value) {
          //       log('changing value to: $value');
          //     },
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: CustomDropdown<String>(
          //     hintText: 'Select',
          //     decoration: CustomDropdownDecoration(
          //         closedBorder: Border.all(color: textFieldColor)),
          //     items: controller.list,
          //     onChanged: (value) {
          //       log('changing value to: $value');
          //     },
          //   ),
          // ),
          verticalGap(15),
          // Divider(height: 0.2,color: Colors.grey[300],),
          const Spacer(),
          Center(
            child: Text(
              "Clear Filter",
              style: textDesigner(15, DefaultTheme().primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          verticalGap(15),
        ],
      ),
    ));
  }

  selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: controller.selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.blue,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      controller.selectedDate = newSelectedDate;
      controller.textEditingController
        ..text = DateFormat.yMMMd().format(controller.selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: controller.textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  showSearchBar() {
    controller.isSearchShow = !controller.isSearchShow;
  }

  void eventDetail(String eventId) {
    Get.toNamed("event-detail",arguments: eventId);
  }

  eventListItems(int index) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Media.height() * 0.080,
              horizontal: Media.width() * 0.150,
            ),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(
                      AppConstants.imageBaseUrl +
                          controller.eventSearchJson.value.data[index].image,
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(Icons.calendar_month,
                                  color: DefaultTheme().primaryColor, size: 18),
                            ),
                          ),
                          const TextSpan(
                              // text: controller.eventSearchJson.value.data[index].date),
                              text: "25-07-2024"),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 15,
                      color: DefaultTheme().primaryColor.withOpacity(0.5),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(Icons.timer,
                                  color: DefaultTheme().primaryColor, size: 18),
                            ),
                          ),
                          const TextSpan(
                              // text: controller.eventSearchJson.value.data[index].time
                              text: "05:30"),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalGap(12),
                Text(
                  controller.eventSearchJson.value.data[index].name,
                  style: textDesigner(18, DefaultTheme().blackColor,
                      fontWeight: FontWeight.bold),
                ),
                verticalGap(12),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.location_on_outlined,
                            color: DefaultTheme().primaryColor, size: 18),
                      ),
                      const TextSpan(
                          // text: controller.eventSearchJson.value.data.location
                          text: "Turkey"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  backButton() {
    return widget.isFromTab
        ? null
        : IconButton(
            padding: const EdgeInsets.only(right: 3),
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 22,
            ));
  }

  title() {
    return widget.isFromTab
        ? SizedBox(
            width: Get.width,
            child: CustomTextFormField(
              maxLine: 1,
              labelText: '',
              hintText: AppStrings.searchEvent,
              controller: controller.searchController,
              onChange: (v) => controller.searchEvents(v),
              isLabel: false,
              // fillerColor: Colors.grey,
            ),
          )
        : Text(
            AppStrings.eventTitle,
            style: textDesigner(23, DefaultTheme().primaryColor,
                fontWeight: FontWeight.bold),
          );
  }

  setAction() {
    return [
      widget.isFromTab != true
          ? IconButton(
              onPressed: () {
                setState(() {
                  widget.isFromTab ? showSearchBar() : showFilter();
                });
              },
              icon: Icon(Icons.filter_alt, color: DefaultTheme().primaryColor))
          : Container()
    ];
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
