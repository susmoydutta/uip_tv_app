import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uip_tv_app/presentation/utils/asset_colors_path.dart';
import 'package:uip_tv_app/presentation/widget/custom_box.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
    required this.height,
    required this.width,
    required this.items,
  });

  final double height;
  final double width;
  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height + 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          final imageUrl = item['url'] ?? '';
          final title = item['title'] ?? 'No Title';
          log('title: $title');
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: CustomBox(
              height: height + 40,
              width: width,
              color: AssetColorsPath.backgroundColors,
              borderRadius: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                      imageUrl,
                      height: height,
                      width: width,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: width * 0.5,
                      ),
                    )
                        : Container(
                      height: height,
                      width: width,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey[600],
                        size: width * 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: AssetColorsPath.textBoldColors,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

