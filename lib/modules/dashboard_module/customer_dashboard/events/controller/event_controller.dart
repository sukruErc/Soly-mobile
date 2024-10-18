import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/model/event_detail_model.dart';
import 'package:solyticket/model/event_search_json.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/repo/event_repo.dart';

class EventController extends GetxController {
  var eventSearchJson = EventSearchJson(data: []).obs;
  late EventRepo eventRepo;
  DateTime? selectedDate;
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  late bool isSearchShow = false;
  late var isSearchLoading = false.obs;

  EventController(this.eventRepo);

  searchEvents(String searchText) async {
    try{
      isSearchLoading(true);
      Map<String, dynamic> data = {"value": searchText};
      await eventRepo.eventSearch(data).then((response) {
        if (response!.statusCode == 200) {
          var searchResult = json.decode(response.data);
          if(searchResult["success"]==true){
            isSearchLoading(false);
            eventSearchJson.value = EventSearchJson.fromJson(searchResult);
          }else{
            isSearchLoading(false);
          }
        }
      });
    }catch(e){
      isSearchLoading(false);
    }
  }
}
