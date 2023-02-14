import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseClient {
  var client = http.Client();

  ///GET
  Future<dynamic> get(String api) async {
    // var headersAPI = {"": ""};

    var url = Uri.parse(api);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response;
    } else {
      //throw exception and catch it in UI
    }
  }

  ///POST
  Future<dynamic> post(String api, dynamic object) async {
    var headersAPI = {"": ""};
    var payload = json.encode(object);

    var url = Uri.parse(api);
    var response = await client.post(url, headers: headersAPI, body: payload);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }
}
