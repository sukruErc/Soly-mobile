import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/utills/global.dart';

class TopBarWidget extends StatelessWidget {
  final String title;
  final String price;
  final String eventId;

  const TopBarWidget({
    Key? key,
    required this.title,
    required this.price,
    required this.eventId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (GlobalClass.userId == "") {
                showDialog(
                  context: context,
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
                        child: Stack(
                          children: [
                            Column(
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
                                  "Lütfen satın alma işlemine devam etmek için giriş yapın veya kayıt olun.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: Colors.black54),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed("login");
                                      },
                                      child: const Text("Giriş Yap"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed("registration");
                                      },
                                      style: ElevatedButton.styleFrom( 
                                        backgroundColor: Colors.blueAccent,
                                      ),
                                      child: const Text("Kayıt Ol"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Icon(Icons.close, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                Get.toNamed("seat-category-selection", arguments: [eventId]);
              }
            },
            // style: ElevatedButton.styleFrom(
            //   backgroundColor: Colors.blue,
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            // ),
            child: const Text("Buy Now"),
          ),
        ],
      ),
    );
  }
}
