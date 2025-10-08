import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:nilecare_flutter/services/storage_service.dart';
import 'storage_service_test.mocks.dart';
import 'dart:io';

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async => '/mock/path';
}

@GenerateMocks([FlutterSecureStorage])
void main() {
  late StorageService storageService;
  late MockFlutterSecureStorage mockSecureStorage;
  late MockPathProviderPlatform mockPathProvider;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    mockPathProvider = MockPathProviderPlatform();
    PathProviderPlatform.instance = mockPathProvider;
    storageService = StorageService();
  });

  group('Secure Storage Tests', () {
    test('Set secure item', () async {
      await storageService.setSecureItem('test-key', 'test-value');
      verify(mockSecureStorage.write(key: 'test-key', value: 'test-value'))
          .called(1);
    });

    test('Get secure item', () async {
      when(mockSecureStorage.read(key: 'test-key'))
          .thenAnswer((_) async => 'test-value');

      final value = await storageService.getSecureItem('test-key');
      expect(value, 'test-value');
    });

    test('Remove secure item', () async {
      await storageService.removeSecureItem('test-key');
      verify(mockSecureStorage.delete(key: 'test-key')).called(1);
    });

    test('Clear secure storage', () async {
      await storageService.clearSecureStorage();
      verify(mockSecureStorage.deleteAll()).called(1);
    });
  });

  group('File Storage Tests', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync();
      when(mockPathProvider.getApplicationDocumentsPath())
          .thenAnswer((_) async => tempDir.path);
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('Save to cache', () async {
      final testData = {'key': 'value'};
      await storageService.saveToCache('test-key', testData);

      final file = File('${tempDir.path}/cache.json');
      expect(await file.exists(), true);

      final contents = await file.readAsString();
      final cache = json.decode(contents);
      expect(cache['test-key']['data'], testData);
    });

    test('Get from cache', () async {
      final testData = {'key': 'value'};
      await storageService.saveToCache('test-key', testData);

      final cachedData = await storageService.getFromCache('test-key');
      expect(cachedData, testData);
    });

    test('Get from cache with expired data', () async {
      final testData = {'key': 'value'};
      await storageService.saveToCache('test-key', testData);

      final cachedData = await storageService.getFromCache(
        'test-key',
        maxAge: const Duration(seconds: -1),
      );
      expect(cachedData, null);
    });

    test('Remove from cache', () async {
      final testData = {'key': 'value'};
      await storageService.saveToCache('test-key', testData);
      await storageService.removeFromCache('test-key');

      final cachedData = await storageService.getFromCache('test-key');
      expect(cachedData, null);
    });

    test('Clear cache', () async {
      final testData = {'key': 'value'};
      await storageService.saveToCache('test-key', testData);
      await storageService.clearCache();

      final file = File('${tempDir.path}/cache.json');
      expect(await file.exists(), false);
    });
  });

  group('Image Cache Tests', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync();
      when(mockPathProvider.getApplicationDocumentsPath())
          .thenAnswer((_) async => tempDir.path);
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('Cache image', () async {
      final imageUrl = 'https://example.com/image.jpg';
      final imageBytes = [1, 2, 3, 4, 5];

      await storageService.cacheImage(imageUrl, imageBytes);

      final cachedImage = await storageService.getCachedImage(imageUrl);
      expect(cachedImage, isNotNull);
      expect(await cachedImage!.readAsBytes(), imageBytes);
    });

    test('Get non-existent cached image', () async {
      final imageUrl = 'https://example.com/nonexistent.jpg';
      final cachedImage = await storageService.getCachedImage(imageUrl);
      expect(cachedImage, null);
    });

    test('Clear image cache', () async {
      final imageUrl = 'https://example.com/image.jpg';
      final imageBytes = [1, 2, 3, 4, 5];

      await storageService.cacheImage(imageUrl, imageBytes);
      await storageService.clearImageCache();

      final cachedImage = await storageService.getCachedImage(imageUrl);
      expect(cachedImage, null);
    });
  });
}
