import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solyticket/controllers/image_picker_controller.dart';

class SelectImageWidget extends StatelessWidget {
  SelectImageWidget({super.key, this.circularImg});
  final Widget? circularImg;

  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        circularImg!,
        Positioned(
          bottom: -5,
          right: -5,
          child: SizedBox(
            height: 50,
            width: 50,
            child: Card(
              shape: getRoundShape(),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.camera_alt),
                onPressed: () {
                  Get.dialog(
                    Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                imagePickerController
                                    .selectImage(isCamera: true)
                                    .then((_) => Get.back());
                              },
                              child: const Text(
                                'Camera',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w100),
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                imagePickerController
                                    .selectImage(isCamera: false)
                                    .then((_) => Get.back());
                              },
                              child: const Text(
                                'Gallery',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w100),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).then((_) {
                    // This block executes after the dialog is dismissed
                    // Check if no image was selected and show a message
                    if (imagePickerController.image.value == null) {
                      Get.snackbar(
                        'No Image Selected',
                        'No image was selected.',
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.all( 10)
                      );
                    }
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Helper function for the card shape
RoundedRectangleBorder getRoundShape() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25.0),
  );
}
