import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();

  // Secure Storage Methods
  Future<void> setSecureItem(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getSecureItem(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> removeSecureItem(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> clearSecureStorage() async {
    await _secureStorage.deleteAll();
  }

  // File Storage Methods
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/cache.json');
  }

  Future<void> saveToCache(String key, dynamic data) async {
    try {
      final file = await _localFile;
      Map<String, dynamic> cache = {};

      if (await file.exists()) {
        final contents = await file.readAsString();
        cache = json.decode(contents) as Map<String, dynamic>;
      }

      cache[key] = {
        'data': data,
        'timestamp': DateTime.now().toIso8601String(),
      };

      await file.writeAsString(json.encode(cache));
    } catch (e) {
      print('Error saving to cache: $e');
    }
  }

  Future<dynamic> getFromCache(String key, {Duration? maxAge}) async {
    try {
      final file = await _localFile;
      if (!await file.exists()) return null;

      final contents = await file.readAsString();
      final cache = json.decode(contents) as Map<String, dynamic>;

      if (!cache.containsKey(key)) return null;

      final cachedData = cache[key];
      final timestamp = DateTime.parse(cachedData['timestamp']);

      if (maxAge != null) {
        final age = DateTime.now().difference(timestamp);
        if (age > maxAge) {
          // Remove expired cache
          cache.remove(key);
          await file.writeAsString(json.encode(cache));
          return null;
        }
      }

      return cachedData['data'];
    } catch (e) {
      print('Error reading from cache: $e');
      return null;
    }
  }

  Future<void> removeFromCache(String key) async {
    try {
      final file = await _localFile;
      if (!await file.exists()) return;

      final contents = await file.readAsString();
      final cache = json.decode(contents) as Map<String, dynamic>;

      cache.remove(key);
      await file.writeAsString(json.encode(cache));
    } catch (e) {
      print('Error removing from cache: $e');
    }
  }

  Future<void> clearCache() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }

  // Image Cache Methods
  Future<String> getImageCachePath(String imageUrl) async {
    final path = await _localPath;
    final fileName = imageUrl.split('/').last;
    return '$path/images/$fileName';
  }

  Future<void> cacheImage(String imageUrl, List<int> imageBytes) async {
    try {
      final path = await getImageCachePath(imageUrl);
      final file = File(path);

      // Create directory if it doesn't exist
      await file.parent.create(recursive: true);

      await file.writeAsBytes(imageBytes);
    } catch (e) {
      print('Error caching image: $e');
    }
  }

  Future<File?> getCachedImage(String imageUrl) async {
    try {
      final path = await getImageCachePath(imageUrl);
      final file = File(path);

      if (await file.exists()) {
        return file;
      }
      return null;
    } catch (e) {
      print('Error getting cached image: $e');
      return null;
    }
  }

  Future<void> clearImageCache() async {
    try {
      final path = await _localPath;
      final imageDir = Directory('$path/images');
      if (await imageDir.exists()) {
        await imageDir.delete(recursive: true);
      }
    } catch (e) {
      print('Error clearing image cache: $e');
    }
  }
}
