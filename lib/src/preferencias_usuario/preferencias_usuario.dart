import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences prefs;

  initPrefs() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return prefs.getString('token') ?? '';
    // return prefs.getString('token') ?? '';
  }

  set token(String value) {
    prefs.setString('token', value);
  }

  get email {
    return prefs.getString('email') ?? '';
    // return prefs.getString('token') ?? '';
  }

  set email(String value) {
    prefs.setString('email', value);
  }

  get displayName {
    return prefs.getString('displayName') ?? '';
    // return prefs.getString('token') ?? '';
  }

  set displayName(String value) {
    prefs.setString('displayName', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    prefs.setString('ultimaPagina', value);
  }
}
