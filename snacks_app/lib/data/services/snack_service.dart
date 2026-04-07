import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/snack_model.dart';

class SnackService {
  final String baseUrl =
      "https://sweetie-catering-api.demohub.tech/api/v1/public/snacks";

  final String imageBase =
      "https://sweetie-catering-api.demohub.tech/api/v1/uploads/";

  String buildImageUrl(String path) {
    if (path.isEmpty) return "";

    // If already full URL → use directly
    if (path.startsWith("http")) return path;

    // Extract filename from any path
    final fileName = path.split('/').last;

    return "$imageBase$fileName";
  }

  Future<List<Snack>> fetchSnacks() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      final menu = body['data']['menu'];

      List<Snack> allSnacks = [];

      void extractItems(String key) {
        final items = menu[key]?['items'] ?? [];

        for (var item in items) {
          final fullImage = buildImageUrl(item['image'] ?? '');

          allSnacks.add(
            Snack.fromJson(
              {
                ...item,
                'image': fullImage, // override with fixed URL
              },
              key, // category
            ),
          );
        }
      }

      // Extract all categories
      extractItems('warme');
      extractItems('koude');
      extractItems('zoete');

      return allSnacks;
    } else {
      throw Exception("Failed to fetch snacks");
    }
  }
}
