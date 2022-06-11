import 'package:app_vacina_animal/animais/vo/animal_vo.dart';
import 'package:app_vacina_animal/vacinas/telas/caixa_dialogo_cadastrar_vacina_pendente.dart';
import 'package:app_vacina_animal/vacinas/vo/vacina_vo.dart';
import 'package:app_vacina_animal/vacinas/servico/servico_vacinas.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VacinasPendentes extends StatefulWidget {
  final AnimalVO animal;
  const VacinasPendentes({required this.animal, key}) : super(key: key);

  @override
  State<VacinasPendentes> createState() => _VacinasPendentesState();
}

class _VacinasPendentesState extends State<VacinasPendentes> {
  ServicosVacina service = ServicosVacina();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: service.getVacinasPendentes(widget.animal),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data != null) {
            final docs = data.docs;
            return ListView.separated(
              itemBuilder: (context, index) {
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
                    trailing: ElevatedButton(
                        onPressed: () {
                          VacinaVO vacina = VacinaVO(
                              docs[index].id, docs[index].get('nome_vacina'));
                          abrirDialogoRegistrarVacina(vacina);
                        },
                        child: const Text('Aplicar')),
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

  abrirDialogoRegistrarVacina(VacinaVO vacina) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CaixaDialogoCadastrarVacinaPendente(
              animal: widget.animal, vacina: vacina);
        });
  }
}
