import 'package:app_vacina_animal/dashboard/dashboard_screen.dart';
import 'package:app_vacina_animal/animais/telas/tela_registrar_animal.dart';
import 'package:app_vacina_animal/aplicador/telas/lista_aplicadores.dart';
import 'package:app_vacina_animal/animais/telas/listar_animal_op_del_edit.dart';
import 'package:app_vacina_animal/animais/telas/lista_animais_opc_vacinar.dart';
import 'package:app_vacina_animal/vacinas/telas/list_todas_vacinas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyA8BsWJRg4dZy7FigHWtXRX2I7UCmCZ6JU",
        appId: "1:698565374837:web:40895cfe26e1785442993c",
        messagingSenderId: "698565374837",
        projectId: "vacina-animal"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const login = '/login_screen';
  static const home = '/home_screen';
  static const telaCadastroAnimal = '/tela_registrar_animal';
  static const listaAnimais = '/lista_animais';
  static const listEditAndDelete = '/listar_animal_op_del_edit';
  static const dashboardScreen = '/dashboard_screen';
  static const registrarVacinacao = '/tela_registrar_vacina';
  static const listAplicadores = '/lista_aplicadores';
  static const listVacinas = '/lista_vacinas';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: login,
        routes: {
          login: (context) => LoginScreen(),
          telaCadastroAnimal: (context) => TelaCadastroAnimal(),
          listEditAndDelete: (context) => const Listamed(),
          dashboardScreen: (context) => DashboardScreen(),
          registrarVacinacao: (context) => const TelaRegistrarVacina(),
          listAplicadores: (context) => const ListaAplicadores(),
          listVacinas: (context) => const ListVacinas()
        });
  }
}
