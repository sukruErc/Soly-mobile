import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:solyticket/modules/booking_module/controller/seat_selection_controller.dart';
import 'package:solyticket/widgets/app_layout.dart';

class SeatSelectionPage extends GetView<SeatSelectionController> {
  SeatSelectionPage({super.key});

  final Set<SeatNumber> selectedSeats = Set();

  @override
  Widget build(BuildContext context) {
    return DefaultAppLayout(
      isAppBar: true,
      title: const Text("Seats"),
      backgroundColor: Colors.white,
      centerTitle: true,
      child: Obx(()=>controller.isLoading.value
          ? const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(),
          ),
        ),
      ):Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            height: 16,
          ),
          Flexible(
            child: SizedBox(
              width: Get.width,
              height: 500,
              child: SeatLayoutWidget(
                onSeatStateChanged: (rowI, colI, seatState) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: seatState == SeatState.selected
                          ? Text("Selected Seat[$rowI][$colI]")
                          : Text("De-selected Seat[$rowI][$colI]"),
                    ),
                  );
                  if (seatState == SeatState.selected) {
                    selectedSeats.add(SeatNumber(rowI: rowI, colI: colI));
                  } else {
                    selectedSeats.remove(SeatNumber(rowI: rowI, colI: colI));
                  }
                },
                stateModel: SeatLayoutStateModel(
                  pathDisabledSeat: 'assets/images/seat_disabled.svg',
                  pathSelectedSeat: 'assets/images/seat_selected.svg',
                  pathSoldSeat: 'assets/images/seat_sold.svg',
                  pathUnSelectedSeat: 'assets/images/seat_unselected.svg',
                  rows: controller.seatList.value.data![0].numOfRows,
                  cols: controller.seatList.value.data![0].numOfColumns,
                  seatSvgSize: 45,
                  currentSeatsState: controller.finalList.value
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/seat_disabled.svg',
                      width: 15,
                      height: 15,
                    ),
                    const Text('Disabled')
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/seat_sold.svg',
                      width: 15,
                      height: 15,
                    ),
                    const Text('Sold')
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/seat_unselected.svg',
                      width: 15,
                      height: 15,
                    ),
                    const Text('Available')
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/seat_selected.svg',
                      width: 15,
                      height: 15,
                    ),
                    const Text('Selected')
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () {
              // setState(() {});
            },
            child: const Text('Show my selected seat numbers'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => const Color(0xFFfc4c4e)),
            ),
          ),
          const SizedBox(height: 12),
          Text(selectedSeats.join(" , "))
        ],
      )),
    );
  }
}

class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI &&
        colI == (other as SeatNumber).colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[$rowI][$colI]';
  }
}
