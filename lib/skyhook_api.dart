import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skyhook/provider.dart';

/// Defines all API interactions with the skyhook backend
class SkyhookApi {
  static const _baseUrl = "https://skyhookapi.com";

  static Future<List<Provider>> providers() async {
    var url = Uri.parse('$_baseUrl/api/providers');
    var response = await http.get(url);
    List<dynamic> providersDynamic =
        (jsonDecode(response.body) as List<dynamic>);
    return providersDynamic.map((e) => Provider.fromJson(e)).toList();
  }
}
