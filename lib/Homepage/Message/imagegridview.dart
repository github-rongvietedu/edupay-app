import 'dart:io';
import 'package:flutter/material.dart';

class ImageGridView extends StatelessWidget {
  final List<String> imageUrls; // List of image URLs (paths)

  ImageGridView({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    int columns = (imageUrls.length == 1) ? 1 : 2;
    return GridView.count(
      crossAxisCount: columns, // Dynamic number of columns (1 or 2)
      crossAxisSpacing: 0.0, // No space between columns
      mainAxisSpacing: 0.0, // No space between rows
      shrinkWrap: true, // Prevent scrolling
      physics: const NeverScrollableScrollPhysics(), // Disable scroll
      children: List.generate(imageUrls.length, (index) {
        return buildImageTile(context, imageUrls[index]);
      }),
    );
  }

  // Build each image tile
  Widget buildImageTile(BuildContext context, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: FileImage(File(imageUrl)), // Load the image from file
          fit: BoxFit.fill, // Cover the container with the image
        ),
      ),
    );
  }
}
