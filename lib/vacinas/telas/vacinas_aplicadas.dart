import 'package:app_vacina_animal/animais/vo/animal_vo.dart';
import 'package:app_vacina_animal/vacinas/servico/aplicar_vacina_service.dart';
import 'package:app_vacina_animal/vacinas/servico/servico_vacinas.dart';
import 'package:app_vacina_animal/vacinas/vo/vacina_vo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VacinasAplicadas extends StatefulWidget {
  final AnimalVO animal;

  const VacinasAplicadas({required this.animal, key}) : super(key: key);

  @override
  State<VacinasAplicadas> createState() => _VacinasAplicadasState();
}

class _VacinasAplicadasState extends State<VacinasAplicadas> {
  ServicosVacina service = ServicosVacina();
  AplicarVacinaService aplicarVacinaService = AplicarVacinaService();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: service.getVacinas(widget.animal),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data != null) {
            final docs = data.docs;
            return ListView.separated(
              itemBuilder: (context, index) {
                VacinaVO vacinaVO =
                    VacinaVO(docs[index].id, docs[index].get('nome_vacina'));
                return Card(
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(
                      docs[index].get('nome_vacina'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '\n Data da aplicação: ${docs[index].get('Data_aplicacao')}',
                          style: const TextStyle(fontSize: 13),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 6),
                        Text(
                            '\n Aplicador: ${docs[index].get('nome_aplicador')}'),
                      ],
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        // ignore: avoid_returning_null_for_void
                        onPressed: () {
                          aplicarVacinaService.deletarVacinaAplicada(
                              widget.animal, vacinaVO);
                          Fluttertoast.showToast(
                            msg: "Vacina excluída com Sucesso!",
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
