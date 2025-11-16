import 'package:flutter/material.dart';
import '../models/carousel_image.dart';

class CarouselImageCard extends StatelessWidget {
  final CarouselImage image;
  final VoidCallback onDelete;

  const CarouselImageCard({
    super.key,
    required this.image,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: ReorderableDragStartListener(
            index: image.order - 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.menu, color: Colors.grey),
                const SizedBox(width: 5),
                Container(
                  width: 40,
                  height: 40,
                  color: Colors.grey.shade200,
                  child: Center(child: Text('${image.order}')),
                ),
              ],
            ),
          ),
          title: Text(
            image.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            image.url,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
