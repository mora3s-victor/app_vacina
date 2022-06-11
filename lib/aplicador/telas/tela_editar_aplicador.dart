import 'package:app_vacina_animal/aplicador/servico/aplicador_service.dart';

import 'package:app_vacina_animal/aplicador/vo/aplicador_vo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TelaEditarAplicador extends StatefulWidget {
  final AplicadorVO aplicador;

  const TelaEditarAplicador({required this.aplicador, Key? key})
      : super(key: key);

  @override
  State<TelaEditarAplicador> createState() => _TelaEditarAplicadorState();
}

class _TelaEditarAplicadorState extends State<TelaEditarAplicador> {
  var idController = TextEditingController();
  var nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idController.text = widget.aplicador.id;
    nomeController.text = widget.aplicador.nome;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Aplicador'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Id do Aplicador',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        enabled: false,
                        keyboardType: TextInputType.name,
                        controller: idController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Nome',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: nomeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, entre com o nome do aplicador';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AplicadorService servico = AplicadorService();
                      AplicadorVO aplicador = AplicadorVO(
                        idController.text,
                        nomeController.text,
                      );
                      servico.atualizarAplicador(aplicador);
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: "Dados modificados com sucesso!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: const Color(0x55000000),
                      );
                    }
                  },
                  child: const Text("Salvar Dados"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
