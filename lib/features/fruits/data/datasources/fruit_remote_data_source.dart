import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/fruit_model.dart';

abstract class FruitRemoteDataSource {
  /// Calls the https://www.fruityvice.com/api/fruit/all endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<List<FruitModel>> getFruits();
}

class FruitRemoteDataSourceImpl implements FruitRemoteDataSource {
  final http.Client client;

  FruitRemoteDataSourceImpl({required this.client});

  @override
  Future<List<FruitModel>> getFruits() async {
    try {
      final url = Uri.https('www.fruityvice.com', '/api/fruit/all');
      final response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => FruitModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
