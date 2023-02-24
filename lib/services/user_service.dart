import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:subapp/models/peers_model.dart';

class UserService {
  static const String baseUrl = 'https://api1.logicdev.com.ng/api';
  final String _token;

  UserService(this._token);

  Future<http.Response> getWalletHistory() async {
    final url = Uri.parse('$baseUrl/wallet-history');
    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    return response;
  }

  Future<http.Response> getUserInfo() async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );
    return jsonDecode(response.body);
  }

  Future<PeerData> getUserPeers(context) async {
    final url = Uri.parse('$baseUrl/peers');
    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    var result = jsonDecode(response.body)['data'];
    return PeerData.fromJson(result);
  }

  Future<http.Response> post(dynamic body) async {
    final url = Uri.parse('$baseUrl/peers');
    final response = await http.post(
      url,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: body,
    );
    return jsonDecode(response.body);
  }
}
