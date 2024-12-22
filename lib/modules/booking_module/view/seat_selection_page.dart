import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:solyticket/modules/booking_module/controller/seat_selection_controller.dart';
import 'package:solyticket/widgets/app_layout.dart';

class SeatSelectionPage extends GetView<SeatSelectionController> {
  SeatSelectionPage({super.key});

  final Set<String> selectedSeatIds = <String>{};

  @override
  Widget build(BuildContext context) {
    return DefaultAppLayout(
      isAppBar: true,
      leading: geriTusu(),
      title: const Text("Koltuklar"),
      backgroundColor: Colors.white,
      centerTitle: true,
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.finalList.isEmpty || controller.seatList.isEmpty) {
          return const Center(
            child: Text("Henüz veri bulunamadı."),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              color: Colors.grey[300],
              child: const Text(
                "SAHNE",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: controller.seatList[0].numOfColumns ?? 1,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  shrinkWrap: true,
                  itemCount: (controller.seatList[0].numOfRows ?? 1) *
                      (controller.seatList[0].numOfColumns ?? 1),
                  itemBuilder: (context, index) {
                    int row = index ~/ (controller.seatList[0].numOfColumns ?? 1);
                    int col = index % (controller.seatList[0].numOfColumns ?? 1);

                    if (row >= controller.finalList.length ||
                        col >= controller.finalList[row].length) {
                      return const SizedBox.shrink();
                    }

                    final seat = controller.finalList[row][col];

                    if (seat.empty) {
                      return const SizedBox.shrink();
                    }

                    return GestureDetector(
                      onTap: () {
                        if (seat.status == "reserved") return;

                        // Seçim işlemleri
                        int selectedPersonCount =
                            int.tryParse(Get.arguments[3]?.toString() ?? '0') ??
                                0;
                        controller.updateSeatState(
                            row, col, selectedPersonCount, selectedSeatIds);
                      },
                      child: Transform.rotate(
                        angle: 3.14159, // 180 derece döndürme
                        child: SvgPicture.asset(
                          koltukDurumIkonu(seat.status ?? ""),
                          width: 45,
                          height: 45,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // legendIcon('assets/images/seat_disabled.svg', 'Kullanılamaz'),
                  legendIcon('assets/images/seat_sold.svg', 'Satılmış'),
                  legendIcon('assets/images/seat_unselected.svg', 'Müsait'),
                  legendIcon('assets/images/seat_selected.svg', 'Seçili'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                controller.sendToPayment(selectedSeatIds);
                // Get.snackbar("Seçili Koltuklar", selectedSeatIds.join(", "));
              },
              child: const Text('Seçili koltuk numaralarımı göster'),
            ),
          ],
        );
      }),
    );
  }

  Widget legendIcon(String asset, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(asset, width: 15, height: 15),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  String koltukDurumIkonu(String status) {
    switch (status) {
      case "available":
        return 'assets/images/seat_unselected.svg';
      case "selected":
        return 'assets/images/seat_selected.svg';
      case "reserved":
        return 'assets/images/seat_sold.svg';
      default:
        return 'assets/images/seat_disabled.svg';
    }
  }

  IconButton geriTusu() {
    return IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.arrow_back_ios_new, size: 22),
    );
  }
}
