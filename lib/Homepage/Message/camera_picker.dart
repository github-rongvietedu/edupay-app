

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();
Future<void> _displayPickImageDialog(
    BuildContext context, OnPickImageCallback onPick) async {
  onPick(1000, 1000, 100);
}
Future<void> onImageButtonPressed(
    var controller,
    Function(dynamic url)? onImagePressed,
    ImageSource source, {
      BuildContext? context,
      bool isMultiImage = false,
    }) async {
  await _displayPickImageDialog(context!,
          (double maxWidth, double maxHeight, int quality) async {
        try {
          if (!isMultiImage) {
            // Single image selection
            final XFile? pickedFile = await _picker.pickImage(source: source);
            if (pickedFile != null) {
              // Pass the image path to the callback function
              onImagePressed?.call(pickedFile.path);
            }
          } else {
            // Multi-image selection
            final List<XFile>? pickedFileList = await _picker.pickMultiImage();
            if (pickedFileList != null && pickedFileList.isNotEmpty) {
              // Collect paths from the selected images
              List<String> temp = [];
              for (var file in pickedFileList) {
                temp.add(file.path);
              }
              // Pass the list of image paths to the callback function
              onImagePressed?.call(temp);
            }
          }
          // Update the controller after the image(s) are picked
          controller.update();
        } catch (e) {
          print('Error picking image(s): ${e.toString()}');
        }
      });
}

typedef OnPickImageCallback = void Function(
    double maxWidth, double maxHeight, int quality);
