import 'package:http/http.dart' as http;

class Api {
  String baseUrl = 'http://192.168.1.6:8000/api/';

  Future login(String endpoint, String email, String password) async {
    String url = baseUrl + endpoint + "?email=$email&password=$password";
    var response = await http.get(url, headers: {'Accept': 'application/json'});
    return response;
  }

  Future getdata(String endPoint, String token) async {
    String url = baseUrl + endPoint;
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return response;
  }
}
