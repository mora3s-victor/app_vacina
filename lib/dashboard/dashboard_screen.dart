// ignore_for_file: avoid_unnecessary_containers

// ignore: must_be_immutable
import 'package:app_vacina_animal/main.dart';
import 'package:flutter/material.dart';

import 'items_dashboard.dart';

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

  @override
  Widget build(BuildContext context) {
    List<ItemsDashboard> myList = [item1, item2, item3];
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        itemCount: myList.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: () => callUnit(ctx, index),
            //detector de gestos. quando clicar no container alguma coisa é executada
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
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
    );
  }

  callUnit(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushNamed(MyApp.telaCadastroAnimal);
    } else if (index == 1) {
      Navigator.of(context).pushNamed(MyApp.listEditAndDelete);
    }
  }
}
