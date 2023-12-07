import 'dart:convert';

import 'package:prova_seventh/1-base/dto/login_request_dto.dart';
import 'package:prova_seventh/1-base/dto/login_response_dto.dart';
import 'package:prova_seventh/1-base/services/base_service.dart';
import 'package:prova_seventh/1-base/services/interfaces/ilogin_service.dart';
import 'package:prova_seventh/2-app/utils/exceptions.dart';
import 'package:prova_seventh/2-app/utils/integrations.dart';

class LoginService extends BaseService implements ILoginService {
  @override
  Future<LoginResponseDTO> login(LoginRequestDTO request) async {
    const url = '${urlAPI}login';
    final response = await post(url, request.toJson());
    if (response.statusCode == 200) {
      return LoginResponseDTO.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw LoginNaoRealizadoException();
    }
  }
}
