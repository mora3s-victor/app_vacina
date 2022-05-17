import 'package:app_vacina_animal/models/services/animal_servico.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListaAnimais extends StatelessWidget {
  const ListaAnimais({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimalServico animalServices = AnimalServico();
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: animalServices.getAnimais(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            final List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: docSnap.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Descrição: ${docSnap[index].get('descricao')}'),
                      Text('Raça: ${docSnap[index].get('raca')}'),
                      Text('Sexo: ${docSnap[index].get('sexo')}'),
                      Text('Peso: ${docSnap[index].get('peso')}'),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == null) {
            return Center(
              child: ListView(children: const [
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text("Não há dados disponíveis"),
                )
              ]),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
