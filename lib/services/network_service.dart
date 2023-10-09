import 'dart:convert';

import 'package:fruits_from_api/models/fruit_model.dart';
import 'package:http/http.dart';

sealed class Network {
  static const String baseUrl = "www.fruityvice.com";
  static const String api = "/api/fruit/all";

  static const Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static Future<String?> methodGet({
    required String api,
    Object? id,
    Map<String, String> headers = headers,
    String baseUrl = baseUrl,
  }) async {
    try {
      Uri url = Uri.https(baseUrl, "$api${id != null ? "/$id" : ""}");
      final response = await get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
      print(response.statusCode);
    } on Exception catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static List<Fruit> parseFruitList(String data) {
    final json = jsonDecode(data) as List;
    return json.map((item) => Fruit.fromJson(item)).toList();
  }

  static Fruit parseFruit(String data) {
    final json = jsonDecode(data);
    final fruits = Fruit.fromJson(json);
    return fruits;
  }
}
