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
  return new Drawer(
    child: ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: Text("APPTIVAWEB"),
          accountEmail: Text("informes@gmail.com"),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://ichef.bbci.co.uk/news/660/cpsprodpb/6AFE/production/_102809372_machu.jpg"),
                  fit: BoxFit.cover)),
        ),
        Ink(
          color: Colors.indigo,
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
          title: Text("Logout"),
          onTap: () {
            final _prefs = new PreferenciasUsuario();
            _prefs.token = '';
            Navigator.pushNamed(context, 'login');
          },
        )
      ],
    ),
  );
}
