import 'package:http/http.dart' as http;
import 'dart:convert';
import 'RefreshToken.dart';
import 'globals.dart' as globals;

class Requests {
  static Future<RefreshToken> login(String _username, String _password) async {
    final response = await http.post(
      'https://briefthreat.nul.ie//api/v1/auth/login', 
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'username' : 'root', 'password' : 'Gpp1zvtjqWZXEf9KE5qDbp1YeP0p4CHTLkZ6tNCrGFV'}));
      //body: {'username' : '$_username', 'password' : '$_password'});  used for actual auth

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON to get the refresh key
      return RefreshToken.fromJson(jsonDecode(response.body));
    } 
    else {
      // If that response was not OK, authentification failed
      return null;
    }
  } 
}