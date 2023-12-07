import 'package:flutter/material.dart';
import 'package:prova_seventh/2-app/modules/login/controllers/login_controller.dart';
import 'package:prova_seventh/2-app/modules/shared/pages/background_widget.dart';
import 'package:prova_seventh/2-app/modules/shared/widgets/button_widget.dart';
import 'package:prova_seventh/2-app/modules/shared/widgets/text_field_widget.dart';
import 'package:prova_seventh/2-app/utils/assets.dart';
import 'package:prova_seventh/2-app/utils/colors.dart';
import 'package:prova_seventh/2-app/utils/instancias.dart';
import 'package:prova_seventh/2-app/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Validators {
  late final LoginController controller;

  @override
  void initState() {
    controller = GerenciadorInstancias().getInstance<LoginController>(LoginController());
    super.initState();
  }

  @override
  void dispose() {
    GerenciadorInstancias().removeInstance<LoginController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(logoSeventhLogin, height: MediaQuery.of(context).size.height * 0.1),
            Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFieldWidget(labelText: "Login", controller: controller.username, validator: defaultValidator),
                    TextFieldWidget(
                      labelText: "Senha",
                      controller: controller.password,
                      passwordField: true,
                      validator: defaultValidator,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
                      child: ButtonWidget(
                        "Entrar",
                        onPressed: () => controller.login(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
