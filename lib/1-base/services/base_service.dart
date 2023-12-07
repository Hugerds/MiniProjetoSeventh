import 'package:http/http.dart' as http;
import 'package:prova_seventh/1-base/dto/login_request_dto.dart';
import 'package:prova_seventh/1-base/services/interfaces/ilogin_service.dart';
import 'package:prova_seventh/2-app/utils/instancias.dart';
import 'package:prova_seventh/2-app/utils/prefs.dart';

class BaseService {
  Future<String> getToken({bool expiredToken = false}) async {
    try {
      if (expiredToken) {
        final username = await secureStorage.readSecurePrefs("login");
        final password = await secureStorage.readSecurePrefs("password");
        if (username == null || password == null) {
          throw Exception();
        }
        final login = await GerenciadorInstancias()
            .getInstance<ILoginService>()
            .login(LoginRequestDTO(username: username, password: password));
        await secureStorage.writeSecurePrefs("token", login.token);
      }
      final token = await secureStorage.readSecurePrefs("token");
      if (token == null) {
        throw Exception();
      }
      return token;
    } catch (_) {
      rethrow;
    }
  }

  Future<http.Response> post(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    headers ??= {};
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    if (response.statusCode != 401) return response;
    final String token = await getToken();
    headers.remove("x-access-token");
    headers.addAll({"x-access-token": token});
    return await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
  }

  Future<http.Response> get(
    String url, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    headers ??= {};
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode != 401) return response;
    final String token = await getToken();
    headers.remove("x-access-token");
    headers.addAll({"x-access-token": token});
    return await http.get(
      Uri.parse(url),
      headers: headers,
    );
  }
}
