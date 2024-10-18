import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/model/event_detail_model.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/controller/event_detail_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/repo/event_detail_repo.dart';
import 'package:solyticket/providers/api_client.dart';

class EventDetailPage extends StatelessWidget {
  EventDetailPage({super.key});

  final eventDetailController = Get.put(
      EventDetailController(EventDetailRepo(apiClient: ApiClient()), Get.arguments));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(),
    );
  }
}
