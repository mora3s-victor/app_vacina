import 'package:app_vacina_animal/telas/home/home_screen.dart';
import 'package:app_vacina_animal/telas/login/sign_up_screen.dart';
import 'package:app_vacina_animal/telas/login/user/user_local.dart';
import 'package:app_vacina_animal/telas/login/user/user_services.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserLocal userLocal = UserLocal();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              width: 280,
              height: 280,
              image: AssetImage('assets/images/login.png'),
            ),
            const Text(
              'App controle vacina',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 180, right: 180, top: 10, bottom: 30),
              child: Column(
                children: [
                  Card(
                    elevation: 1.0,
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                TextFormField(
                                    onSaved: (value) => userLocal.email = value,
                                    initialValue: userLocal.email,
                                    decoration: const InputDecoration(
                                        hintText: 'Email...'),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Por favor, insira o email';
                                      }
                                      return null;
                                    }),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  onSaved: (value) =>
                                      userLocal.password = value,
                                  initialValue: userLocal.password,
                                  decoration: const InputDecoration(
                                      hintText: 'Senha...'),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Por favor, a senha é obrigatória';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    UserServices _userServices = UserServices();
                                    _userServices.signIn(userLocal,
                                        onSuccess: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()));
                                    }, onFail: (e) {
                                      Text('$e');
                                    });
                                  }
                                },
                                child: const Text('Entrar')),
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(),
                                    ),
                                  );
                                },
                                child: const Text('Registrar-se')),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
