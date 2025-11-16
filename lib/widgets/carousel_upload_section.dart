import 'package:flutter/material.dart';

class CarouselUploadSection extends StatelessWidget {
  final String? fileName;
  final TextEditingController descriptionController;
  final VoidCallback onPickFile;
  final VoidCallback onUpload;

  const CarouselUploadSection({
    super.key,
    required this.fileName,
    required this.descriptionController,
    required this.onPickFile,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Unggah Gambar Baru',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    fileName ?? 'Choose File • No file chosen',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              ElevatedButton(
                onPressed: onPickFile,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(50, 50),
                  backgroundColor: Colors.grey.shade200,
                  foregroundColor: Colors.black87,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(Icons.image),
              ),
            ],
          ),

          const SizedBox(height: 15),

          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'Deskripsi / Alt Text',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              isDense: true,
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: onUpload,
            icon: const Icon(Icons.upload),
            label: const Text('Unggah & Tambahkan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
