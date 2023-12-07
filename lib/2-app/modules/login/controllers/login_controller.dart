import 'package:flutter/material.dart';
import 'package:prova_seventh/1-base/dto/login_request_dto.dart';
import 'package:prova_seventh/1-base/dto/login_response_dto.dart';
import 'package:prova_seventh/1-base/services/interfaces/ilogin_service.dart';
import 'package:prova_seventh/2-app/utils/dialogs.dart';
import 'package:prova_seventh/2-app/utils/exceptions.dart';
import 'package:prova_seventh/2-app/utils/instancias.dart';
import 'package:prova_seventh/2-app/utils/prefs.dart';

class LoginController {
  late final ILoginService _loginService;
  late final TextEditingController _username;
  late final TextEditingController _password;
  late final GlobalKey<FormState> _formKey;

  LoginController() {
    _loginService = GerenciadorInstancias().getInstance<ILoginService>();
    _username = TextEditingController();
    _password = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  //Getters
  TextEditingController get username => _username;
  TextEditingController get password => _password;
  GlobalKey<FormState> get formKey => _formKey;

  Future<void> saveResponseLogin(LoginResponseDTO response) async {
    await secureStorage.write(key: "token", value: response.token);
    await secureStorage.write(key: "username", value: _username.text);
    await secureStorage.write(key: "password", value: _password.text);
  }

  Future<void> login(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) throw FormularioInvalidoException();
      final loginRequestDTO = LoginRequestDTO(username: _username.text, password: _password.text);
      final response = await _loginService.login(loginRequestDTO);
      await saveResponseLogin(response);
      // Se houver algum erro de contexto retorna um erro genérico
      if (!context.mounted) throw Exception();
      Navigator.of(context).pushReplacementNamed("/video");
    } on FormatException catch (e) {
      if (e is! FormularioInvalidoException) {
        return defaultDialog(context, title: "Aviso", content: e.message);
      }
    } catch (_) {
      return defaultDialog(context, title: "Aviso", content: "Não foi possível realizar o login");
    }
  }
}
