import 'package:flutter/material.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/profile/view/widget/tickets_page.dart';
import 'widget/user_profile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profil"),
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Profil"),
              Tab(text: "Biletlerim"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserProfile(),
            TicketsPage(),
          ],
        ),
      ),
    );
  }
}
