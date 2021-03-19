import 'dart:async';
import 'package:petcare/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _displayNameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get displayNameStream =>
      _displayNameController.stream.transform(validarDisplayName);
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeDisplayName => _displayNameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el último valor ingresado a los streams
  String get displayName => _displayNameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _displayNameController?.close();
    _emailController?.close();
    _passwordController?.close();
  }
}
