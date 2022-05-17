// ignore_for_file: prefer_const_constructors

import 'package:app_vacina_animal/dashboard/dashboard_screen.dart';
import 'package:app_vacina_animal/telas/first_page.dart';
import 'package:app_vacina_animal/telas/second_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(const FirstPage());
    pageList.add(const SecondPage());
    pageList.add(DashboardScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de vacina animal'),
      ),
      body: IndexedStack(
        //trabalhar com o índice da pilha IndexedStack
        children: pageList, //ao ser executado o metodo onItemTapped
        index: _selectedPage, //o indice é atualizado
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            _selectedPage, //currentIndex recebe como parametro o numero da pagina selecionada,informando qual é o índice atual
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: "Categorias"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
        ],
      ),
    );
  }

  //metodo para atualizar a pagina de acordo com o item selecionado no bottomNavigationBar
  onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
