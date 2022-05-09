import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Defines all API interactions with the skyhook backend
class SkyhookApi {
  static const _baseUrl = "https://skyhookapi.com";

  static Future<List<String>> providers() async {
    var url = Uri.parse('$_baseUrl/providers');
    var response = await http.get(url);
    List<String> providers = (jsonDecode(response.body) as List<dynamic>).cast<String>();
    print(providers);
    return providers;
  }
}
