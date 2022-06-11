import 'package:app_vacina_animal/animais/servico/animal_servico.dart';
import 'package:app_vacina_animal/animais/vo/animal_vo.dart';
import 'package:app_vacina_animal/animais/telas/animal_e_suas_vacinas.dart';
import 'package:app_vacina_animal/vacinas/telas/caixa_dialogo_cadastrar_vacina.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaRegistrarVacina extends StatefulWidget {
  const TelaRegistrarVacina({Key? key}) : super(key: key);

  @override
  State<TelaRegistrarVacina> createState() => _TelaRegistrarVacinaState();
}

class _TelaRegistrarVacinaState extends State<TelaRegistrarVacina> {
  AnimalVO? avo;

  @override
  Widget build(BuildContext context) {
    var service = AnimalServico();
    return Scaffold(
      appBar: AppBar(title: const Text("Registrar Vacina Aplicada")),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: service.getAnimais(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data != null) {
              final docs = data.docs;
              return ListView.separated(
                itemBuilder: (context, index) {
                  AnimalVO animal = AnimalVO(
                    docs[index].id,
                    docs[index].get('codigo'),
                    docs[index].get('descricao'),
                    docs[index].get('raca'),
                    docs[index].get('sexo'),
                    docs[index].get('peso'),
                  );

                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                //CARREGA A TELA PARA APRESENTAR OS DADOS DO ANIMAL E A LISTA DE VACINAS APLICADAS
                                AnimalVacinasAplicadas(animal: animal),
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
                      trailing: ElevatedButton(
                        onPressed: () {
                          _registrarVacina(context, animal);
                        },
                        child: const Text('Registrar vacina'),
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
      ),
    );
  }

  void _registrarVacina(context, AnimalVO animal) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return CaixaDialogoCadastrarVacina(
          animal: animal,
        );
      },
    );
  }
}
