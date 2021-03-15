import 'dart:convert';

import 'package:petcare/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final uri = Uri.https(
        "identitytoolkit.googleapis.com",
        "v1/accounts:signUp",
        {"key": "AIzaSyBtdPsSdmyBqias5-z33rzG40hlTShCz-4"});
    final res = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }));
    Map<String, dynamic> decodedRes = json.decode(res.body);
    print(decodedRes);

    if (decodedRes.containsKey('idToken')) {
      //TODO: Salvar el token en el Storage
      _prefs.token = decodedRes['idToken'];
      return {'ok': true, 'token': decodedRes['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedRes['error']['message']};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final uri = Uri.https(
        "identitytoolkit.googleapis.com",
        "v1/accounts:signInWithPassword",
        {"key": "AIzaSyBtdPsSdmyBqias5-z33rzG40hlTShCz-4"});
    final res = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }));
    Map<String, dynamic> decodedRes = json.decode(res.body);
    print(decodedRes);

    if (decodedRes.containsKey('idToken')) {
      //TODO: Salvar el token en el Storage
      _prefs.token = decodedRes['idToken'];
      return {'ok': true, 'token': decodedRes['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedRes['error']['message']};
    }
  }
}
