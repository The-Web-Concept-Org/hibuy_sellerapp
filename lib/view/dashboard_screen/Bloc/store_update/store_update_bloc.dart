import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/models/store_update_model.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_service.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/store_update/store_update_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/store_update/store_update_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreUpdateState> {
  StoreBloc() : super(const StoreUpdateState()) {
    on<UpdateStoreEvent>(_onUpdateStoreEvent);
  }

  Future<void> _onUpdateStoreEvent(
    UpdateStoreEvent event,
    Emitter<StoreUpdateState> emit,
  ) async {
    emit(state.copyWith(status: StoreUpdateStatus.loading));

    try {
      // 🔹 Prepare form data
      final Map<String, dynamic> formData = {
        "store_name": event.storeName,
      };

      // 🔸 Try BOTH formats for tags (one will work)
      if (event.storeTags.isNotEmpty) {
        // Format 1: Array notation
        for (int i = 0; i < event.storeTags.length; i++) {
          formData["store_tags[$i]"] = event.storeTags[i];
        }
      }

      // 🔸 Add store image (single file)
      if (event.storeImage != null) {
        formData["store_image"] = event.storeImage!;
      }

      // 🔸 Try SIMPLE array format for banner images (matching Postman)
      if (event.bannerImages != null && event.bannerImages!.isNotEmpty) {
        log("🎨 Adding ${event.bannerImages!.length} banner images...");
        
        // Try this simple format first (most common)
        for (int i = 0; i < event.bannerImages!.length; i++) {
          formData["store_banners[$i]"] = event.bannerImages![i];
          log("   Added: store_banners[$i]");
        }
      }

      // 🔸 Try SIMPLE array format for post images (matching Postman)
      if (event.postImages != null && event.postImages!.isNotEmpty) {
        log("📸 Adding ${event.postImages!.length} post images...");
        
        // Try this simple format first
        for (int i = 0; i < event.postImages!.length; i++) {
          formData["store_posts[$i]"] = event.postImages![i];
          log("   Added: store_posts[$i]");
        }
      }

      log("🟢 Final Form Data Prepared:");
      formData.forEach((key, value) {
        log("   $key => $value");
      });

      await ApiService.postMultipartMultipleFilesMethod(
        apiUrl: AppUrl.editStoreProfile,
        formData: formData,
        authHeader: true,
        executionMethod: (bool success, dynamic data) {
          if (success) {
            log("✅ Store Update Success: $data");
            
            // Log response details
            log("🔍 Response Data:");
            log("   store_name: ${data['data']?['store_name']}");
            log("   store_image: ${data['data']?['store_image']}");
            log("   store_tags: ${data['data']?['store_tags']}");
            log("   store_banners: ${data['data']?['store_banners']}");
            log("   store_posts: ${data['data']?['store_posts']}");
            
            final storeUpdate = StoreUpdate.fromJson(data);
            emit(state.copyWith(
              storeUpdate: storeUpdate,
              status: StoreUpdateStatus.success,
              message: data["message"] ?? "Store updated successfully",
            ));
          } else {
            log("❌ Store Update Failed: $data");
            emit(state.copyWith(
              status: StoreUpdateStatus.error,
              message: data["message"] ?? "Something went wrong",
            ));
          }
        },
      );
    } catch (e, st) {
      log("🔥 Exception in StoreBloc: $e");
      log(st.toString());
      emit(state.copyWith(
        status: StoreUpdateStatus.error,
        message: e.toString(),
      ));
    }
  }
}