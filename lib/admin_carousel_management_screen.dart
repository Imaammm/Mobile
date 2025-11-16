import 'package:flutter/material.dart';

import 'models/carousel_image.dart';
import 'widgets/carousel_image_card.dart';
import 'widgets/carousel_upload_section.dart';

// --- Admin Carousel Management Screen ---
class AdminCarouselScreen extends StatefulWidget {
  const AdminCarouselScreen({super.key});

  @override
  State<AdminCarouselScreen> createState() => _AdminCarouselScreenState();
}

class _AdminCarouselScreenState extends State<AdminCarouselScreen> {
  // ignore: prefer_final_fields
  List<CarouselImage> _images = [
    CarouselImage(
      id: 'img-1',
      name: 'Lapangan-img 1',
      url: 'https://firebase.storage.example.com/...',
      altText: 'Gambar Lapangan Tenis 1',
      order: 1,
    ),
    CarouselImage(
      id: 'img-2',
      name: 'Lapangan img 2',
      url: 'https://firebase.storage.example.com/...',
      altText: 'Gambar Lapangan Tenis 2',
      order: 2,
    ),
    CarouselImage(
      id: 'img-3',
      name: 'Lapangan img 3',
      url: 'https://firebase.storage.example.com/...',
      altText: 'Gambar Lapangan Tenis 3',
      order: 3,
    ),
    CarouselImage(
      id: 'img-4',
      name: 'Lapangan img 4',
      url: 'https://firebase.storage.example.com/...',
      altText: 'Gambar Lapangan Tenis 4',
      order: 4,
    ),
    CarouselImage(
      id: 'img-5',
      name: 'Lapangan img 5',
      url: 'https://firebase.storage.example.com/...',
      altText: 'Gambar Lapangan Tenis 5',
      order: 5,
    ),
    CarouselImage(
      id: 'img-6',
      name: 'Lapngan img 6',
      url: 'https://firebase.storage.example.com/...',
      altText: 'Gambar Lapangan Tenis 6',
      order: 6,
    ),
  ];

  String? _fileName;
  final TextEditingController _descriptionController = TextEditingController();

  void _pickFile() {
    setState(() {
      _fileName = 'new_image_${_images.length + 1}.jpg';
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('File dipilih: $_fileName')));
  }

  void _uploadAndAdd() {
    if (_fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih file gambar terlebih dahulu!')),
      );
      return;
    }

    final newImage = CarouselImage(
      id: 'img-${_images.length + 1}',
      name: 'Gambar Baru ${_images.length + 1}',
      url: 'https://firebase.storage.example.com/new_upload.jpg',
      altText: _descriptionController.text.isEmpty
          ? 'Gambar Lapangan'
          : _descriptionController.text,
      order: _images.length + 1,
    );

    setState(() {
      _images.add(newImage);
      _fileName = null;
      _descriptionController.clear();

      _images.sort((a, b) => a.order.compareTo(b.order));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gambar berhasil diunggah dan ditambahkan!'),
      ),
    );
  }

  void _deleteImage(String id) {
    setState(() {
      _images.removeWhere((img) => img.id == id);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Gambar ID $id berhasil dihapus.')));
  }

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;

      final item = _images.removeAt(oldIndex);
      _images.insert(newIndex, item);

      // Update order
      for (int i = 0; i < _images.length; i++) {
        _images[i] = CarouselImage(
          id: _images[i].id,
          name: _images[i].name,
          url: _images[i].url,
          altText: _images[i].altText,
          order: i + 1,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrasi'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text(
                  'Manajemen Gambar Carousel',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Kelola gambar yang ditampilkan di halaman utama (carousel).',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),

                CarouselUploadSection(
                  fileName: _fileName,
                  descriptionController: _descriptionController,
                  onPickFile: _pickFile,
                  onUpload: _uploadAndAdd,
                ),
                const SizedBox(height: 30),

                Text(
                  'Daftar Gambar (${_images.length})',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(height: 20),
              ]),
            ),
          ),

          SliverReorderableList(
            itemCount: _images.length,
            onReorder: _reorder,
            itemBuilder: (context, index) {
              final image = _images[index];
              return CarouselImageCard(
                key: ValueKey(image.id),
                image: image,
                onDelete: () => _deleteImage(image.id),
              );
            },
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  // upload section moved to separate widget: widgets/carousel_upload_section.dart
}

// --- CarouselImageCard widget moved to widgets/carousel_image_card.dart
