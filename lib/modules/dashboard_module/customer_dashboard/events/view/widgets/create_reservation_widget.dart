import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/constants/themes.dart';
import 'package:solyticket/utills/global.dart';
import 'package:solyticket/model/ticket_detail_json.dart';

class CreateTourReservation extends StatefulWidget {
  final List<LabelValueEntity> persons;
  final List<LabelValueEntity> categoryPrices;
  final EventTicketsResponse? tickets;

  const CreateTourReservation({
    Key? key,
    required this.persons,
    required this.categoryPrices,
    this.tickets,
  }) : super(key: key);

  @override
  _CreateTourReservationState createState() => _CreateTourReservationState();
}

class _CreateTourReservationState extends State<CreateTourReservation> {
  LabelValueEntity? selectedPerson;
  LabelValueEntity? selectedCategory;
  int? countdown;
  bool showPopup = false;

  @override
  void initState() {
    super.initState();
    _initializeCountdown();
  }

  void _initializeCountdown() {
    if (widget.tickets?.data.userHeldTickets.isNotEmpty == true) {
      final heldUntil =
          DateTime.parse(widget.tickets!.data.userHeldTickets[0].heldUntil as String);
      final now = DateTime.now();
      setState(() {
        countdown = heldUntil.difference(now).inSeconds;
      });
      if (countdown! > 0) {
        _startCountdown();
      }
    }
  }

  void _startCountdown() {
    Future.doWhile(() async {
      if (countdown != null && countdown! > 0) {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          countdown = countdown! - 1;
        });
        return true;
      }
      return false;
    });
  }

String _getButtonText() {
  final userHeldTickets = widget.tickets?.data.userHeldTickets ?? [];
  final userPurchasedTickets = widget.tickets?.data.userPurchasedTickets ?? [];
  final availableTickets = widget.tickets?.data.availableTickets ?? [];

  if (userPurchasedTickets.isNotEmpty) {
    return "Satın Aldınız";
  } else if (userHeldTickets.isNotEmpty) {
    if (countdown != null && countdown! > 0) {
      final minutes = (countdown! / 60).floor();
      final seconds = countdown! % 60;
      return "Sepete Git (${minutes}:${seconds.toString().padLeft(2, '0')})";
    } else {
      return "Sepete Ekle";
    }
  } else if (availableTickets.isEmpty) {
    return "Tükendi";
  }
  return "Rezervasyon Durumu";
}


  bool _isButtonDisabled() {
    final userHeldTickets = widget.tickets?.data.userHeldTickets ?? [];
    final userPurchasedTickets = widget.tickets?.data.userPurchasedTickets ?? [];
    final availableTickets = widget.tickets?.data.availableTickets ?? [];

    if (userPurchasedTickets.isNotEmpty || availableTickets.isEmpty) {
      return true;
    }
    return false;
  }

  void _handleSubmit() {
    final userId = GlobalClass.userId;
    if (userId == null || userId.isEmpty) {
      setState(() {
        showPopup = true;
      });
      return;
    }

    final queryParams = {
      "category": selectedCategory?.value ?? "",
      "numberOfPerson": selectedPerson?.value ?? "",
    };

    if (widget.tickets?.data.userHeldTickets.isNotEmpty == true) {
      final heldTicketIds =
          widget.tickets!.data.userHeldTickets.map((e) => e.id).join(",");
      // Get.toNamed(
      //   "/events/payment/${widget.data.normalizedEventName}/${widget.shortCode}?tickets=$heldTicketIds",
      // );
    } else {
      final query = queryParams.entries.map((e) => "${e.key}=${e.value}").join("&");
      // Get.toNamed(
      //   "/events/payment/${widget.normalizedEventName}/${widget.shortCode}?$query",
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hadi Başlayalım!",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFD2D2D2)),
        ),
        const SizedBox(height: 8),
        const Text(
          "Rezervasyon oluşturun",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        DropdownButtonFormField<LabelValueEntity>(
          decoration: InputDecoration(
            labelText: "Kişi Sayısı Seçiniz",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items: widget.persons.map((person) {
            return DropdownMenuItem(
              value: person,
              child: Text(person.label),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedPerson = value;
            });
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<LabelValueEntity>(
          decoration: InputDecoration(
            labelText: "Kategori Seçiniz",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items: widget.categoryPrices.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category.label),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
            });
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isButtonDisabled() ? null : _handleSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isButtonDisabled()
                ? Colors.grey
                :  DefaultTheme().primaryColor,
            minimumSize: const Size.fromHeight(50),
          ),
          child: Text(_getButtonText(), style: TextStyle( color: Colors.white),),
        ),
        if (showPopup)
          AlertDialog(
            title: const Text("Giriş veya Kayıt Ol"),
            content: const Text(
                "Lütfen satın alma işlemine devam etmek için giriş yapın veya kayıt olun."),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    showPopup = false;
                  });
                  Get.toNamed("login");
                },
                child: const Text("Giriş Yap"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    showPopup = false;
                  });
                  Get.toNamed("registration");
                },
                child: const Text("Kayıt Ol"),
              ),
            ],
          ),
      ],
    );
  }
}

class LabelValueEntity {
  final String label;
  final String value;

  LabelValueEntity({required this.label, required this.value});
}
