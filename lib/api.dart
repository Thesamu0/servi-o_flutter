import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "";
//nessa variável ficaria o endereço do site para buscar a lista
//nesse caso, seria o "ip do computador/5000"

class API {
  static Future getUsers() {
    return http.get(baseUrl);
  }
}
