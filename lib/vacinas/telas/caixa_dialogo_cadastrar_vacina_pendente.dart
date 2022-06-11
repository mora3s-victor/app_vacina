import 'package:app_vacina_animal/aplicador/servico/aplicador_service.dart';
import 'package:app_vacina_animal/animais/vo/animal_vo.dart';
import 'package:app_vacina_animal/aplicador/vo/aplicador_vo.dart';
import 'package:app_vacina_animal/vacinas/servico/aplicar_vacina_service.dart';
import 'package:app_vacina_animal/vacinas/vo/vacina_vo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaixaDialogoCadastrarVacinaPendente extends StatefulWidget {
  final AnimalVO animal;
  final VacinaVO vacina;
  const CaixaDialogoCadastrarVacinaPendente(
      {required this.animal, required this.vacina, key})
      : super(key: key);

  @override
  State<CaixaDialogoCadastrarVacinaPendente> createState() =>
      _CaixaDialogoCadastrarVacinaPendenteState();
}

class _CaixaDialogoCadastrarVacinaPendenteState
    extends State<CaixaDialogoCadastrarVacinaPendente> {
  String? dataAplicVacina;

  List<VacinaVO> listVacinaVO = [];
  VacinaVO? vacinVO;

  List<AplicadorVO> listAplicadorVO = [];
  AplicadorVO? aplicVO;

  //AQUI VAI A INSTANCIA DA CLASSE DE SERVIÇOS PARA PERSISTIR A VACINA NO BANCO
  @override
  Widget build(BuildContext context) {
    final dropDownVacina = ValueNotifier('');
    final dropDownAplicador = ValueNotifier('');
    final listVacina = [widget.vacina.nome as String];
    AplicarVacinaService aplicarVacinaService = AplicarVacinaService();
    AplicadorService aplicadorService = AplicadorService();

    return AlertDialog(
      title: const Text("Registrar vacina"),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Vacina: '),
                ValueListenableBuilder(
                    valueListenable: dropDownVacina,
                    builder: (BuildContext context, String value, _) {
                      return DropdownButton<String>(
                        value: listVacina.first,
                        onChanged: (escolha) =>
                            dropDownVacina.value = escolha.toString(),
                        items: listVacina
                            .map(
                              (op) => DropdownMenuItem(
                                value: op,
                                child: Text(op),
                              ),
                            )
                            .toList(),
                      );
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Aplicador: '),
                StreamBuilder<QuerySnapshot>(
                  stream: aplicadorService.getAplicadores(),
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    if (data != null) {
                      return ValueListenableBuilder(
                          valueListenable: dropDownAplicador,
                          builder: (BuildContext context, String value, _) {
                            List<String> listaAplicadores = [];
                            for (int i = 0; i < data.size; i++) {
                              String vac = data.docs[i].get('nome_aplicador');
                              AplicadorVO aplicadorVO = AplicadorVO(
                                  data.docs[i].id,
                                  data.docs[i].get('nome_aplicador'));
                              listAplicadorVO.add(aplicadorVO);
                              listaAplicadores.add(vac);
                            }
                            return DropdownButton<String>(
                              elevation: 1,
                              style: const TextStyle(color: Colors.deepPurple),
                              hint: const Text('selecione o aplicador '),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => dropDownAplicador.value =
                                  instanciarAplicador(escolha as String),
                              items: listaAplicadores
                                  .map(
                                    (opcoes) => DropdownMenuItem(
                                      value: opcoes,
                                      child: Text(opcoes),
                                    ),
                                  )
                                  .toList(),
                            );
                          });
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Data de aplicação",
              ),
              autofocus: true,
              onChanged: (text) => dataAplicVacina = text,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancelar"),
        ),
        TextButton(
            onPressed: () {
              aplicarVacinaService.registrarVacina(
                  widget.animal, aplicVO!, widget.vacina, dataAplicVacina!);

              Navigator.of(context).pop();
            },
            child: const Text("Adicionar"))
      ],
    );
  }

  String instanciarAplicador(String escolha) {
    for (int i = 0; i < listAplicadorVO.length; i++) {
      if (escolha == listAplicadorVO[i].nome) {
        aplicVO = listAplicadorVO[i];
      }
    }
    return escolha.toString();
  }
}

/** StreamBuilder<QuerySnapshot>(
                  stream: servicosVacina.getEstoqueVacina(),
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    if (data != null) {
                      return ValueListenableBuilder(
                          valueListenable: dropDownVacina,
                          builder: (BuildContext context, String value, _) {
                            return DropdownButton<String>(
                              elevation: 1,
                              style: const TextStyle(color: Colors.deepPurple),
                              hint: const Text('selecione a vacina '),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) =>
                                  dropDownVacina.value = escolha.toString(),
                              items: data.docs[1]
                                  .get('nome')
                                  .map(
                                    (opcoes) => DropdownMenuItem(
                                      value: opcoes,
                                      child: Text(opcoes),
                                    ),
                                  )
                                  .toList(),
                            );
                          });
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                */

/**ValueListenableBuilder(
                        valueListenable: dropDownVacina,
                        builder: (BuildContext context, String value, _) {
                          /*  Map<String, dynamic> vacinas =
                              servicosVacina.getEstoqueVacina();

                          for (int i = 0; i < vacinas.length;) {
                            VacinaVO vac = (VacinaVO.fromMap(vacinas));
                            listaVacinas.add(vac.nome as String);
                          }*/
                          return DropdownButton<String>(
                            elevation: 1,
                            style: const TextStyle(color: Colors.deepPurple),
                            hint: const Text('selecione a vacina '),
                            value: (value.isEmpty) ? null : value,
                            onChanged: (escolha) =>
                                dropDownVacina.value = escolha.toString(),
                            items: vacinaItens
                                .map(
                                  (opcoes) => DropdownMenuItem(
                                    value: opcoes,
                                    child: Text(opcoes),
                                  ),
                                )
                                .toList(),
                          );
                        }),
 */
