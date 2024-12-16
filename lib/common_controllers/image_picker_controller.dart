import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  // Rxn<XFile> image = Rxn<XFile>();
  // final ImagePicker picker = ImagePicker();

  Future<void> selectImage({bool? isCamera}) async {
    try {
      // final XFile? photo = await picker.pickImage(
      //   source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
      // );

      // if (photo != null) {
      //   image.value = photo;
      // } else {
        
      //   Get.snackbar(
      //     'No Image Selected',
      //     'No image was selected from the gallery.',
      //     snackPosition: SnackPosition.BOTTOM,
      //   );
      // }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while picking the image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

