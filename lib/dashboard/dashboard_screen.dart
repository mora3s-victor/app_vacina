// ignore_for_file: avoid_unnecessary_containers

// ignore: must_be_immutable
import 'package:app_vacina_animal/main.dart';
import 'package:flutter/material.dart';

import 'items_dashboard.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  ItemsDashboard item1 = ItemsDashboard(
    "Cadastrar Animal",
    "",
    "assets/images/petcadastrar.jpg",
  );

  ItemsDashboard item2 = ItemsDashboard(
    "Animais Cadastrados",
    "",
    "assets/images/petscadastrados.jpg",
  );

  ItemsDashboard item3 = ItemsDashboard(
    "Registrar Vacinação",
    "",
    "assets/images/registrarvacinação.jpg",
  );

  ItemsDashboard item4 = ItemsDashboard(
    'Aplicadores',
    '',
    'assets/images/aplicadores.jpg',
  );

  ItemsDashboard item5 = ItemsDashboard(
    'Vacinas',
    '',
    'assets/images/vacinas.jpg',
  );

  @override
  Widget build(BuildContext context) {
    List<ItemsDashboard> myList = [item1, item2, item3, item4, item5];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de vacina animal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: myList.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () => callUnit(ctx, index),
              //detector de gestos. quando clicar no container alguma coisa é executada
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      Image.asset(myList[index].image),
                      Text(myList[index].title),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  callUnit(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushNamed(MyApp.telaCadastroAnimal);
    } else if (index == 1) {
      Navigator.of(context).pushNamed(MyApp.listEditAndDelete);
    } else if (index == 2) {
      Navigator.of(context).pushNamed(MyApp.registrarVacinacao);
    } else if (index == 3) {
      Navigator.of(context).pushNamed(MyApp.listAplicadores);
    } else if (index == 4) {
      Navigator.of(context).pushNamed(MyApp.listVacinas);
    }
  }
}
