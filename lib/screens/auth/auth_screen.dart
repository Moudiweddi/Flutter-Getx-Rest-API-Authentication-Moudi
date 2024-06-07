import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_registration/controllers/login_controller.dart';
import 'package:login_registration/controllers/registeration_controller.dart';
import 'package:login_registration/screens/auth/widgets/input_fields.dart';
import 'package:login_registration/screens/auth/widgets/submit_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  RegisterationController registerationController =
      Get.put(RegisterationController());

  LoginController loginController = Get.put(LoginController());

  var isLogin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: Center(
            child: Obx(
              () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: Text(
                        'WELCOME',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: !isLogin.value ? Colors.white : Colors.amber,
                          onPressed: () {
                            isLogin.value = false;
                          },
                          child: const Text('Register'),
                        ),
                        MaterialButton(
                          color: isLogin.value ? Colors.white : Colors.amber,
                          onPressed: () {
                            isLogin.value = true;
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    isLogin.value ? loginWidget() : registerWidget()
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerWidget() {
    return Column(
      children: [
        InputTextFieldWidget(registerationController.nameController, 'name'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.emailController, 'email address'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.passwordController, 'password'),
        const SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () => registerationController.registerWithEmail(),
          title: 'Register',
        )
      ],
    );
  }

  Widget loginWidget() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.emailController, 'email address'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.passwordController, 'password'),
        const SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () => loginController.loginWithEmail(),
          title: 'Login',
        )
      ],
    );
  }
}
