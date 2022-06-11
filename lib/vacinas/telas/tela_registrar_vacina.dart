import 'package:app_vacina_animal/vacinas/servico/servico_vacinas.dart';
import 'package:app_vacina_animal/vacinas/vo/vacina_vo.dart';
import 'package:flutter/material.dart';

class TelaRegistrarVacinas extends StatefulWidget {
  const TelaRegistrarVacinas({Key? key}) : super(key: key);

  @override
  State<TelaRegistrarVacinas> createState() => _TelaRegistrarVacinasState();
}

class _TelaRegistrarVacinasState extends State<TelaRegistrarVacinas> {
  TextEditingController nomeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    VacinaVO vacinaVO;
    return AlertDialog(
        content: SingleChildScrollView(
      child: ListBody(
        children: [
          const Text('Nome da vacina'),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: nomeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, digite o nome da vacina"';
                      } else {
                        return null;
                      }
                    }),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar')),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    vacinaVO = VacinaVO('', nomeController.text);
                    ServicosVacina service = ServicosVacina();
                    service.addVacina(vacinaVO);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Adicionar'),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
