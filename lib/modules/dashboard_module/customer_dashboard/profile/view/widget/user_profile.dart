import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/profile_controller.dart';

class UserProfile extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();
  final RxBool copied = false.obs; // Reactive variable to track copy status

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.indigo,
                          child: Text(
                            controller.userInfo['name']?.substring(0, 1) ?? "?",
                            style: const TextStyle(fontSize: 40, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          controller.userInfo['name'] ?? "Kullanıcı",
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Name Field
                  _buildNonEditableField(
                    label: "Ad Soyad",
                    value: controller.userInfo['name'],
                  ),
                  const SizedBox(height: 16),

                  // Email Field with Modal Update
                  _buildEmailUpdateField(context),
                  const SizedBox(height: 16),

                  // Phone Number Field
                  _buildNonEditableField(
                    label: "Telefon",
                    value: controller.userInfo['phone'],
                  ),
                  const SizedBox(height: 16),

                  // Birthday Field
                  _buildNonEditableField(
                    label: "Doğum Tarihi",
                    value: DateFormat('dd-MM-yyyy').format(DateTime.parse(controller.userInfo['birthday'])),
                  ),
                  const SizedBox(height: 16),

                  // Blockchain Wallet Field with Copy Button
                  _buildBlockchainField(),
                ],
              ),
            ),
    );
  }

  Widget _buildNonEditableField({required String label, required String? value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.transparent, // Match the background color
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value ?? "",
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

Widget _buildEmailUpdateField(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("E-posta", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: Obx(
              () => Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  controller.userInfo['email'] ?? "",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => _showEmailUpdateModal(context),
            child: const Text("Güncelle"),
          ),
        ],
      ),
    ],
  );
}


  void _showEmailUpdateModal(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController(text: controller.userInfo['email']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("E-posta Güncelle"),
          content: TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Yeni E-posta",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("İptal"),
            ),
            ElevatedButton(
              onPressed: () {
                controller.updateEmail(emailController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Kaydet"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBlockchainField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Blockchain Cüzdanı", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.transparent, // Match the background color
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  controller.userInfo['bcAddress'] ?? "",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                if (controller.userInfo['bcAddress'] != null) {
                  Clipboard.setData(ClipboardData(text: controller.userInfo['bcAddress']));
                  copied.value = true;
                  Future.delayed(const Duration(seconds: 2), () {
                    copied.value = false;
                  });
                  Get.snackbar("Başarılı", "Blockchain adresi kopyalandı");
                }
              },
              child: Obx(
                () => Text(copied.value ? "Kopyalandı" : "Kopyala"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
