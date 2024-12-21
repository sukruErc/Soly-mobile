import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/app_constant.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/model/filters_json.dart';
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
    super.initState();
    String? initialCategoryId = Get.arguments?['initialCategoryId'];
    controller = Get.put(
      EventController(EventRepo(apiClient: ApiClient()), widget.isFromTab,
          initialCategoryId: initialCategoryId),
    );
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
              : widget.isFromTab
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.eventSearchJson.value.data.length,
                      itemBuilder: (context, index) {
                        final item =
                            controller.eventSearchJson.value.data[index];
                        return InkWell(
                          onTap: () {
                            eventDetail(controller
                                .eventSearchJson.value.data[index].id);
                          },
                          child: eventListItems(item),
                        );
                      })
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.eventFilterJson.value.data.length,
                      itemBuilder: (context, index) {
                        final item =
                            controller.eventFilterJson.value.data[index];
                        return InkWell(
                          onTap: () {
                            eventDetail(controller
                                .eventFilterJson.value.data[index].id);
                          },
                          child: eventListItems(item),
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
                  "Filtreler",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "Kapat",
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
          SizedBox(
            height: 250,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextFormField(
                      maxLine: 1,
                      labelText: '',
                      hintText: 'Tarih Seç',
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
                  verticalGap(15),
                  Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButtonFormField<String>(
                          value: controller.selectedSortOrder.value,
                          decoration: InputDecoration(
                            hintText: 'Sırala',
                            suffixIcon: controller.selectedSortOrder.value ==
                                    null
                                ? null
                                : IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      controller.selectedSortOrder.value = null;
                                      applyFilter();
                                    }),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: DefaultTheme().textFieldColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: DefaultTheme().textFieldColor),
                            ),
                          ),
                          onChanged: (newValue) {
                            controller.selectedSortOrder.value = newValue;
                            applyFilter();
                          },
                          items: controller.filtersJson.value.data?.orderTypes
                              .map<DropdownMenuItem<String>>((OrderType value) {
                            return DropdownMenuItem<String>(
                              value: value.id,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                      )),
                  verticalGap(15),
                  Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButtonFormField<String>(
                          value: controller.selectedLocationId.value,
                          decoration: InputDecoration(
                            hintText: 'Mekan',
                            suffixIcon:
                                controller.selectedLocationId.value == null
                                    ? null
                                    : IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          controller.selectedLocationId.value =
                                              null;
                                          applyFilter();
                                        }),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: DefaultTheme().textFieldColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: DefaultTheme().textFieldColor),
                            ),
                          ),
                          onChanged: (newValue) {
                            controller.selectedLocationId.value = newValue;
                            applyFilter();
                          },
                          items: controller.filtersJson.value.data?.locations
                              .map<DropdownMenuItem<String>>((Location value) {
                            return DropdownMenuItem<String>(
                              value: value.id,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                      )),
                  verticalGap(15),
                  Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButtonFormField<String>(
                          value: controller.selectedCatId.value,
                          decoration: InputDecoration(
                            hintText: 'Kategori',
                            suffixIcon: controller.selectedCatId.value == null
                                ? null
                                : IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      controller.selectedCatId.value = null;
                                      applyFilter();
                                    }),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: DefaultTheme().textFieldColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: DefaultTheme().textFieldColor),
                            ),
                          ),
                          onChanged: (newValue) {
                            controller.selectedCatId.value = newValue;
                            controller.setSubCategoryList(newValue);
                            applyFilter();
                          },
                          items: controller.filtersJson.value.data?.categories
                              .map<DropdownMenuItem<String>>((Category value) {
                            return DropdownMenuItem<String>(
                              value: value.id,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                      )),
                  Obx(() {
                    return controller.subCatTypeList.isEmpty
                        ? Container()
                        : Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: List.generate(
                                controller.subCatTypeList.length, (index) {
                              var subCategory =
                                  controller.subCatTypeList[index];
                              return GestureDetector(
                                onTap: () =>
                                    controller.setSelectedSubCategory(index),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    color: subCategory.isSelected
                                        ? Colors.blue
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    subCategory.name,
                                    style: TextStyle(
                                      color: subCategory.isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                  }),
                  verticalGap(15),
                  Obx(() => controller.selectedCatId.value == null
                      ? Container()
                      : showCategoryType()),
                ],
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              controller.clearFilter();
            },
            child: Center(
              child: Text(
                "Filtreyi Temizle",
                style: textDesigner(15, DefaultTheme().primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          verticalGap(15),
        ],
      ),
    ));
  }

  selectDate(BuildContext context) async {
    DateTimeRange? newSelectedDate = await showDateRangePicker(
      context: context,
      // initialDate: controller.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
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
      },
    );

    if (newSelectedDate != null) {
      controller.setDate(newSelectedDate);
    }
  }

  showSearchBar() {
    controller.isSearchShow = !controller.isSearchShow;
  }

  void eventDetail(String eventId) {
    Get.toNamed("event-detail", arguments: eventId);
  }

  eventListItems(var item) {
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
                      AppConstants.imageBaseUrl + item.image,
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
                  item.name,
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

  showCategoryType() {
    return Wrap(
      direction: Axis.horizontal,
      children: List.generate(controller.catTypeList.length, (index) {
        return GestureDetector(
          onTap: () {
            controller.setCategoryType(index);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                  color: controller.catTypeList[index].isSelected
                      ? Colors.blue
                      : Colors.white,
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.catTypeList[index].name,
                  style: TextStyle(
                      color: controller.catTypeList[index].isSelected
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void applyFilter() {
    controller.getFilteredEvents(
        controller.selectedLocationId.value,
        controller.selectedCatId.value,
        controller.selectedCatTypeId.value,
        controller.startDate,
        controller.endDate,
        "date",
        controller.selectedSortOrder.value);
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
