import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackCouponController extends GetxController {

  ImagePicker _imagePicker = Get.find();
  final filePath = ''.obs;

  Future<void> getImage() async {
    final picked = await _imagePicker.getImage(source: ImageSource.gallery);
    filePath.value = picked?.path ?? '';
  }

  void deleteImage() {
    filePath.value = '';
  }

  final rating = 0.0.obs;

  var feedbackContent = "".obs;

  void saveFeedback(String content){
    feedbackContent.value = content;
  }


  void changeRating(double number){
    rating.value = number;
  }

}