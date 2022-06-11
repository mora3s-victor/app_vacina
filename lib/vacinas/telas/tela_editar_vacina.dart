import 'package:app_vacina_animal/vacinas/servico/servico_vacinas.dart';
import 'package:app_vacina_animal/vacinas/vo/vacina_vo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TelaEditarVacina extends StatefulWidget {
  final VacinaVO vacina;

  const TelaEditarVacina({required this.vacina, Key? key}) : super(key: key);

  @override
  State<TelaEditarVacina> createState() => _TelaEditarVacinaState();
}

class _TelaEditarVacinaState extends State<TelaEditarVacina> {
  var idController = TextEditingController();
  var nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idController.text = widget.vacina.id!;
    nomeController.text = widget.vacina.nome!;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Vacina'),
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
                        'Id da Vacina',
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
                      ServicosVacina servico = ServicosVacina();
                      VacinaVO vacinaVO = VacinaVO(
                        idController.text,
                        nomeController.text,
                      );
                      servico.atualizarVacina(vacinaVO);
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
