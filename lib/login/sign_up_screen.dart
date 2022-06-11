import 'package:app_vacina_animal/helpers/validators.dart';
import 'package:flutter/material.dart';

import 'user/user_local.dart';
import 'user/user_services.dart';

class SignUpScreen extends StatelessWidget {
  // utiliado para que possamos acessar o formulário nesta tela
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final UserLocal userLocal = UserLocal();
  //final UserServices userServices = UserServices();

  SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar conta de usuário'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Nome Completo'),
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Campo Obrigatório!!!';
                    } else if (name.trim().split('').length <= 1) {
                      return 'Preencha seu nome completo';
                    }
                    return null;
                  },
                  //evita o uso de controladores
                  onSaved: (name) => userLocal.name = name,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Campo Obrigatório!!!';
                    } else if (!emailValidator(email)) {
                      return 'E-mail Inválido!!!';
                    }
                    return null;
                  },
                  onSaved: (email) =>
                      userLocal.email = email, // salva o email diretamente
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (password) {
                    if (password!.isEmpty) {
                      return 'Campo Obrigatório!!!';
                    } else if (password.length < 6) {
                      return 'A senha deve ter ao menos  caracteres!!!';
                    }
                    return null;
                  },
                  onSaved: (password) => userLocal.password = password,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Repita a senha'),
                  obscureText: true,
                  validator: (password) {
                    if (password!.isEmpty) {
                      return 'Campo Obrigatório!!!';
                    } else if (password.length < 6) {
                      return 'A senha deve ter ao menos  caracteres!!!';
                    }
                    return null;
                  },
                  onSaved: (password) => userLocal.confirmPassword = password,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      //chama o metodo onSave de cada um dos formField
                      // os campos devem ter onSave habilitados
                      formkey.currentState!.save();
                      if (userLocal.password != userLocal.confirmPassword) {
                        const ScaffoldMessenger(
                          child: SnackBar(
                            content: Text(
                              'Senhas não coincidem!!!',
                              style: TextStyle(fontSize: 11),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      UserServices userServices = UserServices();
                      userServices.signUp(
                        userLocal,
                        onSuccess: () {
                          Navigator.of(context).pop();
                        },
                        onFail: (e) {
                          ScaffoldMessenger(
                            child: SnackBar(
                              content: Text(
                                'Falha ao registar Usuário: $e',
                                style: const TextStyle(fontSize: 11),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
