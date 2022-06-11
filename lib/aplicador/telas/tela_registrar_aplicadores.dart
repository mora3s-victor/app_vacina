import 'package:app_vacina_animal/aplicador/servico/aplicador_service.dart';
import 'package:app_vacina_animal/aplicador/vo/aplicador_vo.dart';
import 'package:flutter/material.dart';

class TelaRegistrarAplicadores extends StatefulWidget {
  const TelaRegistrarAplicadores({Key? key}) : super(key: key);

  @override
  State<TelaRegistrarAplicadores> createState() =>
      _TelaRegistrarAplicadoresState();
}

class _TelaRegistrarAplicadoresState extends State<TelaRegistrarAplicadores> {
  TextEditingController nomeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AplicadorVO aplicador;
    return AlertDialog(
        content: SingleChildScrollView(
      child: ListBody(
        children: [
          const Text('Nome do aplicador'),
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
                        return 'Por favor, digite o nome do aplicador"';
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
                    aplicador = AplicadorVO('', nomeController.text);
                    AplicadorService service = AplicadorService();
                    service.addAplicador(aplicador);
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
