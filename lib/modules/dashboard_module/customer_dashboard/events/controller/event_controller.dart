import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solyticket/model/category_type.dart';
import 'package:solyticket/model/event_filter_json.dart';
import 'package:solyticket/model/event_search_json.dart';
import 'package:solyticket/model/filters_json.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/repo/event_repo.dart';

class EventController extends GetxController {
  var eventSearchJson = EventSearchJson(data: []).obs;
  var eventFilterJson = EventFilterJson(data: []).obs;
  var filtersJson = FiltersJson(data: null).obs;
  var catTypeList = <CategoryType>[].obs;
  late EventRepo eventRepo;
  DateTime? startDate;
  DateTime? endDate;
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  late bool isSearchShow = false;
  late bool isFromTab = false;
  late var isSearchLoading = false.obs;
  var selectedCatId = Rxn();
  var selectedCatTypeId = Rxn();
  var selectedSortOrder = Rxn();
  var selectedLocationId = Rxn();
  var selectedStartDate = Rxn();
  var selectedEndDate = Rxn();

  EventController(this.eventRepo, this.isFromTab);

  @override
  onInit() {
    if (!isFromTab) {
      getAllFilterData();
    }
    super.onInit();
  }

  searchEvents(String searchText) async {
    try {
      isSearchLoading(true);
      Map<String, dynamic> data = {"value": searchText};
      await eventRepo.eventSearch(data).then((response) {
        if (response!.statusCode == 200) {
          var searchResult = json.decode(response.data);
          if (searchResult["success"] == true) {
            isSearchLoading(false);
            eventSearchJson.value = EventSearchJson.fromJson(searchResult);
          } else {
            isSearchLoading(false);
          }
        }
      });
    } catch (e) {
      isSearchLoading(false);
    }
  }

  getFilteredEvents(String? locId, String? catId, String? catTypeId,
      DateTime? stD, DateTime? enD, String? sortBy, String? sortOrder) async {
    var locationId, categoryId, categoryTypeId, startDt, endDt, srtBy, srtOrder;
    try {
      isSearchLoading(true);
      Map<String, dynamic> data = {"page": "1", "size": "20"};
      if (locId!=null) {
        locationId = <String, dynamic>{"locationId": locId}.entries;
        data.addEntries(locationId);
      }
      if (catId!=null) {
        categoryId = <String, dynamic>{"categoryId": catId}.entries;
        data.addEntries(categoryId);
      }
      if (catTypeId!=null) {
        categoryTypeId = <String, dynamic>{"categoryTypeId": catTypeId}.entries;
        data.addEntries(categoryTypeId);
      }
      if (stD!=null) {
        startDt = <String, dynamic>{"startDate": DateFormat.yMMMd().format(startDate!)}.entries;
        data.addEntries(startDt);
      }
      if (enD!=null) {
        endDt = <String, dynamic>{"endDate": DateFormat.yMMMd().format(endDate!)}.entries;
        data.addEntries(endDt);
      }
      if (sortBy!=null) {
        srtBy = <String, dynamic>{"sortBy": sortBy}.entries;
        data.addEntries(srtBy);
      }
      if (sortOrder!=null) {
        if(sortOrder=="1"){
          srtOrder = <String, dynamic>{"sortOrder": "asc"}.entries;
        }else{
          srtOrder = <String, dynamic>{"sortOrder": "desc"}.entries;
        }
        data.addEntries(srtOrder);
      }
      await eventRepo.eventFilter(data).then((response) {
        if (response!.statusCode == 200) {
          var searchResult = json.decode(response.data);
          if (searchResult["success"] == true) {
            isSearchLoading(false);
            eventFilterJson.value = EventFilterJson.fromJson(searchResult);
          } else {
            isSearchLoading(false);
          }
        }
      });
    } catch (e) {
      isSearchLoading(false);
    }
  }

  Future getAllFilterData() async {
    try {
      isSearchLoading(true);
      Map<String, dynamic> data = {"page": "1", "size": "20"};
      final results = await Future.wait([
        eventRepo.eventFilter(data),
        eventRepo.getFilters(),
      ]);

      try {
      var searchResult = json.decode(results[0]?.data);
      if (searchResult["success"] == true) {
        eventFilterJson.value = EventFilterJson.fromJson(searchResult);
      }
      } catch (e) {
        // do nothing here
      }
      try {
      var result = json.decode(results[1]?.data);
      if (result["success"] == true) {
        isSearchLoading(false);
        filtersJson.value = FiltersJson.fromJson(result);
      }
      } catch (e) {
        isSearchLoading(false);
        // do nothing here
      }
    } catch (e) {
      isSearchLoading(false);
      //print
    }
  }

  getFilters() async {
    try {
      await eventRepo.getFilters().then((response) {
        if (response!.statusCode == 200) {
          var result = json.decode(response.data);
          if (result["success"] == true) {
            filtersJson.value = FiltersJson.fromJson(result);
          }
        }
      });
    } catch (e) {
      //print
    }
  }

  setCategoryType(int index) {
    try {
      var a = catTypeList
          .firstWhere((e) => e.isSelected == true);
      a.isSelected = false;
    } catch (e) {
      //print
    }
    try {
      selectedCatTypeId.value = catTypeList[index].id;
      catTypeList[index].isSelected = true;
      catTypeList.refresh();
      getFilteredEvents(selectedLocationId.value, selectedCatId.value, selectedCatTypeId.value, startDate, endDate, "date", selectedSortOrder.value);
    } catch (e) {
      //print
    }
  }

  setDate(DateTimeRange newSelectedDate) {
    startDate = newSelectedDate.start;
    endDate = newSelectedDate.end;
    textEditingController
      ..text = DateFormat.yMMMd().format(startDate!) +
          "-" +
          DateFormat.yMMMd().format(endDate!)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: textEditingController.text.length,
          affinity: TextAffinity.upstream));

    getFilteredEvents(selectedLocationId.value, selectedCatId.value,selectedCatTypeId.value, startDate!, endDate!, "date", selectedSortOrder.value);
  }

  void clearFilter() {
    selectedLocationId.value = null;
    selectedCatId.value = null;
    selectedCatTypeId.value = null;
    selectedSortOrder.value = null;
    startDate = null;
    endDate = null;
    getFilteredEvents(selectedLocationId.value, selectedCatId.value,selectedCatTypeId.value, startDate, endDate, "date", selectedSortOrder.value);
  }
}
