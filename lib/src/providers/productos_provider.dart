import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:petcare/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:petcare/src/models/producto_model.dart';

class ProductosProvider {
  final String _url =
      'flutter-varios-60121-default-rtdb.europe-west1.firebasedatabase.app';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto(ProductoModel producto) async {
    final res = await http.post(
        Uri.https(_url, 'productos.json', {"auth": "${_prefs.token}"}),
        body: productoToJson(producto));
    final decodedData = json.decode(res.body);
    print(decodedData);
    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final res = await http.put(
        Uri.https(
            _url, 'productos/${producto.id}.json', {"auth": "${_prefs.token}"}),
        //Uri.https(_url, 'productos/${producto.id}.json'),
        body: productoToJson(producto));
    final decodedData = json.decode(res.body);
    print(decodedData);
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final res = await http.get(
      Uri.https(_url, 'productos.json', {"auth": "${_prefs.token}"}),
    );
    final Map<String, dynamic> decodedData = json.decode(res.body);
    final List<ProductoModel> productos = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
    });
    //print(productos);
    return productos;
  }

  Future<int> eliminarProducto(String id) async {
    final res = await http.delete(
      Uri.https(_url, 'productos/$id.json', {"auth": "${_prefs.token}"}),
    );
    final decodedData = json.decode(res.body);
    print(decodedData);
    return 1;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dqumv04x5/image/upload?upload_preset=kfwtkijr');
    final mimeType = mime(imagen.path).split('/');
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url,
    );
    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final res = await http.Response.fromStream(streamResponse);

    if (res.statusCode != 200 && res.statusCode != 201) {
      print('Algo salió mal');
      print(res.body);
      return null;
    }

    final resData = json.decode(res.body);
    print(resData);
    return resData['secure_url'];
  }
}
