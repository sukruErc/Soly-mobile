import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/profile/controller/profile_controller.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/profile/repo/profile_repo.dart';
import 'package:solyticket/providers/api_client.dart';
import 'package:solyticket/utills/global.dart';
import 'widget/tickets_page.dart';
import 'widget/user_profile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(
      ProfileController(repo: ProfileRepo(apiClient: ApiClient())),
      permanent: false,
    );

    // Eğer kullanıcı ID'si yoksa giriş/kayıt diyalogu göster
    if (GlobalClass.userId == "" || GlobalClass.userId.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoginDialog(context);
      });
    } else {
      // Sayfa her açıldığında veri çek
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.userInfo.isEmpty || controller.tickets.isEmpty) {
          controller.fetchUserInfo();
          controller.fetchUserTickets();
        }
      });
    }

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

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Giriş veya Kayıt Ol",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Lütfen profil bilgilerini görüntülemek veya biletlerinizi görmek için giriş yapın veya kayıt olun.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Get.toNamed("login");
                      },
                      child: const Text("Giriş Yap"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Get.toNamed("registration");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DefaultTheme().primaryColor,
                      ),
                      child: const Text(
                        "Kayıt Ol",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
