import 'package:prova_seventh/1-base/services/interfaces/ilogin_service.dart';
import 'package:prova_seventh/1-base/services/interfaces/iplayer_service.dart';
import 'package:prova_seventh/1-base/services/login_service.dart';
import 'package:prova_seventh/1-base/services/video_service.dart';

/// Gerenciador de instâncias para injeção de dependência, baseado no padrão Singleton
/// Poderia ser implementado com Get_It, por exemplo
class GerenciadorInstancias {
  static final GerenciadorInstancias _instancia = GerenciadorInstancias._();
  factory GerenciadorInstancias() {
    return _instancia;
  }
  GerenciadorInstancias._();

  final Map<String, dynamic> _instancias = {};

  void registerInstance<T>(dynamic instancia) {
    _instancias[T.toString()] = instancia;
  }

  T getInstance<T>([dynamic instance]) {
    final foundInstance = _instancias[T.toString()];
    if (foundInstance != null) return foundInstance as T;
    registerInstance<T>(instance);
    return getInstance<T>();
  }

  void removeInstance<T>() {
    _instancias.remove(T.toString());
  }
}

void registerIntances() {
  GerenciadorInstancias().registerInstance<ILoginService>(LoginService());
  GerenciadorInstancias().registerInstance<IVideoService>(VideoService());
}
