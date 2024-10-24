import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService  {
  
  static final StorageService _storageService = StorageService._internal();

  factory StorageService() {
    return _storageService;
  }

  StorageService._internal();


  final firebaseStorage = FirebaseStorage.instance;

  // Image in firebase storage
  List<String> _imageUrl = [];

  bool _isLoading = false;

  bool _isUpLoading = false;

  // GETTER

  List<String> get imageUrls => _imageUrl;
  bool get isLoading => _isLoading;
  bool get isUpLoading => _isUpLoading;

  Future<void> fetchImages() async {
    _isLoading = true;
    final ListResult results =
        await firebaseStorage.ref("uploaded_images/").listAll();
    final urls =
        await Future.wait(results.items.map((ref) => ref.getDownloadURL()));
    _imageUrl = urls;
    _isLoading = false;
  }

  Future<void> deleteImages(String url) async {
    try {
      _imageUrl.remove(url);
      final String path = extractPathFromUrl(url);
      await firebaseStorage.ref(path).delete();
    } catch (e) {
      print("error: $e");
    }
  }

  Future<String?> uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null; // Không chọn ảnh
    }

    File file = File(image.path);
    try {
      String filePath =
          'uploaded_images/${DateTime.now().millisecondsSinceEpoch}.png';
      await firebaseStorage.ref(filePath).putFile(file);
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error $e");
      return null; // Gặp lỗi
    } finally {
      
    }
  }

  String extractPathFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String encodedPath = uri.pathSegments.last;
    return Uri.decodeComponent(encodedPath);
  }
}
