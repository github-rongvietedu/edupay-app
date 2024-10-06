
import 'dart:io';

import 'package:flutter/foundation.dart';

Future<Uint8List?> getFileBytes(String filePath) async {
  try {
    File file = File(filePath);
    List<int> imageBytes = await File(filePath).readAsBytes();
    return Uint8List.fromList(imageBytes);
  }catch (e) {}
  return null;
}
