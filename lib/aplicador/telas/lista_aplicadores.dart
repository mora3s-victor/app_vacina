import 'package:app_vacina_animal/aplicador/servico/aplicador_service.dart';
import 'package:app_vacina_animal/aplicador/telas/tela_registrar_aplicadores.dart';
import 'package:app_vacina_animal/aplicador/vo/aplicador_vo.dart';
import 'package:app_vacina_animal/aplicador/telas/tela_editar_aplicador.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListaAplicadores extends StatelessWidget {
  const ListaAplicadores({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var service = AplicadorService();
    return Scaffold(
      appBar: AppBar(title: const Text("Aplicadores Cadastrados")),
      body: StreamBuilder<QuerySnapshot>(
        stream: service.getAplicadores(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data != null) {
            final docs = data.docs;
            return ListView.separated(
              itemBuilder: (context, index) {
                AplicadorVO aplicadorVO = AplicadorVO(
                    docs[index].id, docs[index].get('nome_aplicador'));
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              TelaEditarAplicador(aplicador: aplicadorVO),
                        ),
                      );
                    },
                    title: Text(
                      docs[index].get('nome_aplicador'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        // ignore: avoid_returning_null_for_void
                        onPressed: () {
                          service.deletarAplicador(docs[index].id);
                          Fluttertoast.showToast(
                            msg: "Aplicador excluído com Sucesso!",
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FloatingActionButton(
          onPressed: () {
            abrirDialogoRegistrarVacina(context);
          },
          tooltip: 'Adicionar aplicador',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  abrirDialogoRegistrarVacina(context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return const TelaRegistrarAplicadores();
        });
  }
}
