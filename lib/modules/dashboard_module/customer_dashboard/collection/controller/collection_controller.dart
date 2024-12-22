import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:solyticket/model/collection_model.dart';
import 'package:solyticket/model/coupon_model.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/collection/repo/collection_repo.dart';
import 'package:solyticket/utills/global.dart';

class CollectionController extends GetxController {
  final CollectionRepo repo;

  CollectionController({required this.repo});

  var collections = <CollectionModel>[].obs;
  var selectedCollection = Rxn<CollectionModel>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCollections();
  }

  void fetchCollections() async {
    try {
      isLoading.value = true;
      if (GlobalClass.userId != "") {
        var response = await repo.getCollections(GlobalClass.userId);
        if (response?.data != null) {
          var rawData = jsonDecode(response!.data);
          if (rawData['success'] == true && rawData['data'] is List) {
            var data = rawData['data'] as List;
            collections.assignAll(
              data
                  .map((e) =>
                      CollectionModel.fromJson(e as Map<String, dynamic>))
                  .toList(),
            );
          } else {
            throw Exception("Unexpected response format: $rawData");
          }
        }
      }
    } catch (e) {
      Get.snackbar(
        "Hata",
        "Koleksiyonlar yüklenirken bir hata oluştu. Lütfen daha sonra tekrar deneyin.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void redeemCoupon(String userId, String collectionId) async {
    try {
      isLoading.value = true;
      var response = await repo.redeemCoupon(
          {"userId": GlobalClass.userId, "collectionId": collectionId});
      if (response?.data != null) {
        var coupon = CouponModel.fromJson(response!.data);
        collections.value = collections.map((col) {
          if (col.id == collectionId) {
            col.coupons.add(coupon);
          }
          return col;
        }).toList();
      }
    } catch (e) {
      Get.snackbar(
        "Hata",
        "Kupon alma işlemi sırasında bir hata oluştu. Lütfen daha sonra tekrar deneyin.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onRedeemCoupon(CollectionModel collection) async {
    if (collection == null) return;
    try {
      isLoading.value = true;
      var response = await repo.redeemCoupon({
        "userId": GlobalClass.userId,
        "collectionId": collection.id,
      });
      if (response?.data != null) {
        var responseData = response?.data['data'];
        if (responseData == null) {
          throw Exception("Geçersiz yanıt verisi");
        }
        var coupon = CouponModel.fromJson(responseData);
        collections.value = collections.map((col) {
          if (col.id == collection.id) {
            col.coupons.add(coupon);
          }
          return col;
        }).toList();
        Get.snackbar(
          "Başarılı",
          "Kupon başarıyla alındı: ${coupon.code}",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        throw Exception("Beklenmedik yanıt formatı: ${response?.data}");
      }
    } catch (e) {
      String errorMessage =
          "Kupon alma işlemi başarısız. Lütfen daha sonra tekrar deneyin.";
      if (e is DioException && e.response?.data != null) {
        try {
          var errorData = e.response?.data;
          if (errorData is String) {
            errorData = jsonDecode(errorData);
          }
          errorMessage = errorData['message'] ?? errorMessage;
        } catch (_) {}
      }
      Get.snackbar(
        "Hata",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void openModal(CollectionModel collection) {
    selectedCollection.value = collection;
  }

  void closeModal() {
    selectedCollection.value = null;
  }
}
