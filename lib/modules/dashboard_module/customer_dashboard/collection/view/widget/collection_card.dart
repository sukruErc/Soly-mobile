import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:solyticket/model/collection_model.dart';

class CollectionCard extends StatefulWidget {
  final CollectionModel collection;
  final VoidCallback onOpenModal;
  final VoidCallback onRedeemCoupon;

  const CollectionCard({
    required this.collection,
    required this.onOpenModal,
    required this.onRedeemCoupon,
  });

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  bool copied = false; // Tracks if the coupon code was copied

  void handleCopyToClipboard(String code) {
    Clipboard.setData(ClipboardData(text: code));
    setState(() {
      copied = true; // Set the button to "Copied"
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        copied = false; // Reset button after 2 seconds
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Kupon kopyalandı!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allAttended = widget.collection.events.every((event) => event.attended);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Collection Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://ipfs.io/ipfs/${widget.collection.image}",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 50),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Collection Name
            Text(
              widget.collection.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),

            // Discount Percentage
            Row(
              children: [
                const Icon(Icons.local_offer, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  "İndirim Oranı: ${widget.collection.discountPercentage}%",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Expiration Date
            Row(
              children: [
                const Icon(Icons.event, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  "Sona Erme Tarihi: ${DateFormat('dd-MM-yyyy').format(widget.collection.expireAt)}",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // "View Events" Button
            ElevatedButton(
              onPressed: widget.onOpenModal,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Etkinlikleri Gör",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            // Coupon Section
            if (widget.collection.coupons.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kupon Kodu",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Coupon Code TextField
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                            text: widget.collection.coupons.first.code,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Copy Button
                      ElevatedButton(
                        onPressed: () =>
                            handleCopyToClipboard(widget.collection.coupons.first.code),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              copied ? Colors.green : Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          copied ? "Kopyalandı" : "Kopyala",
                          style: const TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            else if (allAttended)
              ElevatedButton(
                onPressed: widget.onRedeemCoupon,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Kuponu Al",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
