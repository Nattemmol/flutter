import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../api_keys.dart';

class IngredientRecognitionService {
  static const String _visionUrl =
      'https://vision.googleapis.com/v1/images:annotate?key=${ApiKeys.googleCloudVision}';

  Future<List<String>> recognizeIngredients(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);
    final body = jsonEncode({
      'requests': [
        {
          'image': {'content': base64Image},
          'features': [
            {'type': 'LABEL_DETECTION', 'maxResults': 10}
          ]
        }
      ]
    });
    final response = await http.post(
      Uri.parse(_visionUrl),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final labels = data['responses'][0]['labelAnnotations'] as List?;
      if (labels != null) {
        return labels.map((l) => l['description'].toString()).toList();
      }
    }
    return [];
  }
}
