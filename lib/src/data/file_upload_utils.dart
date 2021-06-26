import 'dart:io';

import 'package:get/get.dart';

class FileUploadUtils {
  static MultipartFile convertToMultipart(String path) {
    return MultipartFile(File(path),
        filename: 'files', contentType: 'application/x-tar');
  }
}
