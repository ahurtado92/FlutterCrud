import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:petcare/src/bloc/provider.dart';
import 'package:petcare/src/utils/utils.dart';
import 'package:petcare/src/models/producto_model.dart';
import 'package:petcare/src/providers/productos_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'producto_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context).loginBloc;

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _crearListado(context),
      drawer: crearDrawerBottomNavigationBar(context),
      floatingActionButton: _crearBoton(context),
      bottomNavigationBar: crearBottomNavigationBar(context),
    );
  }

  _crearListado(BuildContext context) {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          productosProvider.eliminarProducto(producto.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              (producto.fotoUrl == null)
                  ? Image(image: AssetImage('assets/no-image.png'))
                  : FadeInImage(
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage(producto.fotoUrl),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text('${producto.titulo} - ${producto.valor}'),
                subtitle: Text(producto.id),
                onTap: () => Navigator.pushNamed(context, 'producto',
                    arguments: producto),
              ),
            ],
          ),
        ));
  }

  onGoBack(dynamic value) {
    print('test!');
    setState(() {});
  }

  _pushNameToProducto() async {
    Route route = MaterialPageRoute(builder: (context) => ProductoPage());
    await Navigator.push(context, route).then(onGoBack);
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () => _pushNameToProducto());
  }
}

/**
 * 
 */
