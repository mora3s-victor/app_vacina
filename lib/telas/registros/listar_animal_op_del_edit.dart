import 'package:app_vacina_animal/models/services/animal_servico.dart';
import 'package:app_vacina_animal/models/vo/animal_vo.dart';
import 'package:app_vacina_animal/telas/registros/tela_editar_animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Listamed extends StatelessWidget {
  const Listamed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var service = AnimalServico();
    return Scaffold(
      appBar: AppBar(title: const Text("Animais Cadastrados")),
      body: StreamBuilder<QuerySnapshot>(
        stream: service.getAnimais(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data != null) {
            final docs = data.docs;
            return ListView.separated(
              itemBuilder: (context, index) {
                AnimalVO animal = AnimalVO(
                  docs[index].get('codigo'),
                  docs[index].get('descricao'),
                  docs[index].get('raca'),
                  docs[index].get('sexo'),
                  docs[index].get('peso'),
                  id: docs[index].id,
                );
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              TelaEditarAnimal(animal: animal),
                        ),
                      );
                    },
                    title: Text(
                      docs[index].get('codigo'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      docs[index].get('raca'),
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        // ignore: avoid_returning_null_for_void
                        onPressed: () {
                          service.deletarAnimal(docs[index].id);
                          Fluttertoast.showToast(
                            msg: "Animal excluído com Sucesso!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: const Color(0x55000000),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: docs.length,
            );
          }
          //
          else if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: const [
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text("Não há dados disponíveis"),
                ),
              ],
            );
          }
          //
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
