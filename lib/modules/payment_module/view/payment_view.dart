import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/modules/payment_module/controller/payment_contoller.dart';


class PaymentPage extends StatelessWidget {
  final PaymentController controller = Get.find<PaymentController>();
  final TextEditingController couponController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.eventName.value),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sipariş Özeti Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sipariş Özeti',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rezervasyon süresi: ${formatTime(controller.timer.value)}',
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.unHold();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              child: const Text(
                                'Siparişi İptal Et',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Ticket Image and Details
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              'https://ipfs.io/ipfs/${controller.ticketData.isNotEmpty ? controller.ticketData[0].ipfsImage : ''}',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error, size: 100),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.eventName.value} - ${controller.ticketData.isNotEmpty ? controller.ticketData[0].heldUntil.split("T")[0] : ''}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: controller.ticketData.map((ticket) {
                                    return Text(
                                      ticket.seat.title,
                                      style: const TextStyle(
                                          color: Colors.grey),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${controller.ticketData.isNotEmpty ? controller.ticketData[0].price : 0}₺',
                                  style: const TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Ara Toplam'),
                            Text(
                                '${controller.calculateSubtotal()}₺ x ${controller.selectedSeatIds.length} Kişi')
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Hizmet Bedeli'), Text('10₺')],
                        ),
                        if (controller.discount.value > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'İndirim (${controller.discount.value}%)'),
                                Text(
                                  '-${controller.calculateDiscount()}₺',
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Toplam',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              '${controller.calculateTotal()}₺',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: couponController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Hediye veya indirim kodu',
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                controller.applyCoupon(
                                    couponController.text.trim());
                              },
                              child: const Text('Uygula'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Ödeme Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 3,
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ödeme',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 16),
                        TextField(
                          controller: cardNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Kart Numarası',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: expiryDateController,
                                decoration: const InputDecoration(
                                  labelText: 'Son Kullanma Tarihi',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: cvvController,
                                decoration: const InputDecoration(
                                  labelText: 'CVV',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.end, // Align SVGs to the right
                          children: [
                            SvgPicture.asset(
                              'assets/images/visa.svg',
                              width: 50,
                              placeholderBuilder: (context) => const Icon(
                                Icons.image,
                                size: 50,
                              ),
                            ),
                            const SizedBox(width: 8),
                            SvgPicture.asset(
                              'assets/images/mastercard.svg',
                              width: 50,
                              placeholderBuilder: (context) => const Icon(
                                Icons.image,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Payment logic
                          },
                          child: Text('${controller.calculateTotal()}₺ Öde',
                              style: const TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(fontSize: 18),
                            backgroundColor: DefaultTheme().primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Kişisel bilgileriniz, siparişinizin işlenmesi, Solyticket deneyiminizi desteklemek ve gizlilik politikamızda belirtilen diğer amaçlar için kullanılacaktır.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
