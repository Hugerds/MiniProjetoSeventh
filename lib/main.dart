import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prova_seventh/2-app/modules/login/pages/login_page.dart';
import 'package:prova_seventh/2-app/modules/player/pages/video_page.dart';
import 'package:prova_seventh/2-app/utils/instancias.dart';
import 'package:prova_seventh/2-app/utils/prefs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  registerIntances();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'Prova Seventh',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {"/login": (_) => const LoginPage(), "/video": (_) => const VideoPage()},
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
