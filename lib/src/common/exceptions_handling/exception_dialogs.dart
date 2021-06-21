import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ExceptionDialogs {
  static void showApiException(
      int statusCode, BuildContext context, Function onPressed) {
    switch (statusCode) {
      case HttpStatus.badRequest:
        Alert(
          context: context,
          type: AlertType.error,
          title: "Errors",
          desc: "Something went wrong, please try again later!",
        ).show();
        break;
      default:
    }
  }
}
