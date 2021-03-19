import 'package:flutter/material.dart';
import 'package:petcare/src/preferencias_usuario/preferencias_usuario.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}

BottomNavigationBar crearBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    currentIndex: 0, // this will be set when a new tab is tapped
    items: [
      BottomNavigationBarItem(
        icon: new Icon(Icons.home),
        title: new Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.mail),
        title: new Text('Messages'),
      ),
      BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profile'))
    ],
  );
}

Drawer crearDrawerBottomNavigationBar(BuildContext context) {
  final _prefs = new PreferenciasUsuario();
  return new Drawer(
    child: ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: Text(_prefs.displayName,
              style: TextStyle(color: Colors.deepPurple)),
          accountEmail:
              Text(_prefs.email, style: TextStyle(color: Colors.deepPurple)),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://down-yuantu.pngtree.com/58pic/34/35/46/auto_63558PICtMGS5xycfcCDb_PIC2018.jpg?e=1616157237&st=Y2E5ZjFmYjY3Y2MwMmIwMjdiMTI4NzM1NDMwM2NhNzk&n=%E2%80%94Pngtree%E2%80%94cute+wind+single+dog+background_1145665.jpg"),
                  fit: BoxFit.cover)),
        ),
        Ink(
          color: Colors.deepPurple,
          child: new ListTile(
            title: Text(
              "MENU 1",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        new ListTile(
          title: Text("MENU 2"),
          onTap: () {},
        ),
        new ListTile(
          title: Text("MENU 3"),
        ),
        new ListTile(
          title: Text("CERRAR SESION"),
          onTap: () {
            final _prefs = new PreferenciasUsuario();
            _prefs.token = '';
            _prefs.email = '';
            Navigator.pushNamed(context, 'login');
          },
        )
      ],
    ),
  );
}
