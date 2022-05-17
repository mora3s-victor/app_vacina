import 'package:app_vacina_animal/dashboard/dashboard_screen.dart';
import 'package:app_vacina_animal/telas/cadastro/tela_registrar_animal.dart';
import 'package:app_vacina_animal/telas/home/home_screen.dart';
import 'package:app_vacina_animal/telas/login/login_screen.dart';
import 'package:app_vacina_animal/telas/registros/lista_animais.dart';
import 'package:app_vacina_animal/telas/registros/listar_animal_op_del_edit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
          home: (context) => const HomeScreen(),
          telaCadastroAnimal: (context) => TelaCadastroAnimal(),
          listaAnimais: (context) => const ListaAnimais(),
          listEditAndDelete: (context) => const Listamed(),
          dashboardScreen: (context) => DashboardScreen()
        });
  }
}
