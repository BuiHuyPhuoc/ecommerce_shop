import 'package:ecommerce_shop/services/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    await Provider.of<StorageService>(context, listen: false).fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageService>(
      builder: (context, storageService, child) {
        final List<String> imageUrls = storageService.imageUrls;
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => storageService.uploadImage(),
            child: Icon(Icons.add),
          ),
          body: ListView.builder(itemBuilder: (context, index) {
            final String imageUrl = imageUrls[index];
            return Image.network(imageUrl);
          }),
        );
      },
    );
  }
}
