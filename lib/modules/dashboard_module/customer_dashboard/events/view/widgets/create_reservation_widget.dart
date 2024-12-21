import 'package:flutter/material.dart';
import 'package:solyticket/constants/themes.dart';

class CreateTourReservation extends StatelessWidget {
  final List<LabelValueEntity> persons;
  final List<LabelValueEntity> categoryPrices;
  // final String shortCode;
  // final String normalizedEventName;

  const CreateTourReservation({
    required this.persons,
    required this.categoryPrices,
    // required this.shortCode,
    // required this.normalizedEventName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? selectedPerson;
    String? selectedCategory;
    bool buttonDisabled = false;
    String buttonText = "Rezervasyon Durumu";

    // Replace these with actual logic for tickets
    final bool hasPurchasedTickets = false;
    final bool hasHeldTickets = false;
    final int countdown = 0; // Countdown logic would go here

    if (hasPurchasedTickets) {
      buttonText = "Satın Aldınız";
      buttonDisabled = true;
    } else if (hasHeldTickets && countdown > 0) {
      final minutes = (countdown / 60).floor();
      final seconds = countdown % 60;
      buttonText = "Sepete Git ($minutes:${seconds.toString().padLeft(2, '0')})";
    } else if (categoryPrices.isEmpty) {
      buttonText = "Tükendi";
      buttonDisabled = true;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hadi Başlayalım!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFD2D2D2)),
          ),
          const SizedBox(height: 4),
          const Text(
            "Rezervasyon oluşturun",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Text(
            "Kişi sayısı ve kategori seçiniz",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "Kişi Sayısı Seçiniz",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            items: persons.map((person) {
              return DropdownMenuItem(
                value: person.value,
                child: Text(person.label),
              );
            }).toList(),
            onChanged: (value) {
              selectedPerson = value;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "Kategori Seçiniz",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            items: categoryPrices.map((category) {
              return DropdownMenuItem(
                value: category.value,
                child: Text(category.label),
              );
            }).toList(),
            onChanged: (value) {
              selectedCategory = value;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: buttonDisabled ? null : () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonDisabled ? Colors.grey : DefaultTheme().primaryColor,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(buttonText, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 32),
          const Text(
            "Kategori Fiyatları",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Column(
            children: categoryPrices.map((category) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(78, 67, 241, 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(category.label, style: const TextStyle(fontSize: 16)),
                    Text("1 Kişi x ${category.label} ₺", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class LabelValueEntity {
  final String label;
  final String value;

  LabelValueEntity({required this.label, required this.value});
}
