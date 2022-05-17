import 'package:app_vacina_animal/models/services/animal_servico.dart';
import 'package:app_vacina_animal/models/vo/animal_vo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TelaEditarAnimal extends StatefulWidget {
  final AnimalVO animal;

  const TelaEditarAnimal({required this.animal, Key? key}) : super(key: key);

  @override
  State<TelaEditarAnimal> createState() => _TelaEditarAnimalState();
}

class _TelaEditarAnimalState extends State<TelaEditarAnimal> {
  var codigoAnimalController = TextEditingController();
  var descricaoController = TextEditingController();
  var racaController = TextEditingController();
  var sexoController = TextEditingController();
  var pesoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    codigoAnimalController.text = widget.animal.codigo!;
    descricaoController.text = widget.animal.descricao!;
    racaController.text = widget.animal.raca!;
    sexoController.text = widget.animal.sexo!;
    pesoController.text = widget.animal.peso!;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Animal"),
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
                        'Codigo do Animal',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: codigoAnimalController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, entre com o código do animal';
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
                      const Text(
                        'Descrição',
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
                        controller: descricaoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, entre com a descricao do animal';
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
                      const Text(
                        'Raça',
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
                        controller: racaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, entre com a raça do animal';
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
                      const Text(
                        'Sexo',
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
                        controller: sexoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, entre com o sexo do animal';
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
                      const Text(
                        'Peso',
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
                        controller: pesoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, entre com o peso do animal';
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
                      AnimalServico servico = AnimalServico();
                      AnimalVO animal = AnimalVO(
                        codigoAnimalController.text,
                        descricaoController.text,
                        racaController.text,
                        sexoController.text,
                        pesoController.text,
                        id: widget.animal.id,
                      );
                      servico.atualizarAnimal(animal);
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
