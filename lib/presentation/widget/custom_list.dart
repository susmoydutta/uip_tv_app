import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const CustomList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final imageUrl = item['url'] ?? '';
          final title = item['title'] ?? 'No Title';
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: imageUrl.isNotEmpty
                            ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 80,
                          ),
                        )
                            : Container(
                          height: 100,
                          width: 140,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey[600],
                            size: 80,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 5,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Season 1 Episode 1",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
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
