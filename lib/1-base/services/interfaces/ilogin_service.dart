import 'package:prova_seventh/1-base/dto/login_request_dto.dart';
import 'package:prova_seventh/1-base/dto/login_response_dto.dart';

abstract class ILoginService {
  Future<LoginResponseDTO> login(LoginRequestDTO request);
}
