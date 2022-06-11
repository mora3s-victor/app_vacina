// ignore_for_file: must_be_immutable

import 'package:app_vacina_animal/main.dart';
import 'package:app_vacina_animal/animais/servico/animal_servico.dart';
import 'package:app_vacina_animal/animais/vo/animal_vo.dart';
import 'package:flutter/material.dart';

class TelaCadastroAnimal extends StatelessWidget {
  TelaCadastroAnimal({Key? key}) : super(key: key);
  TextEditingController codigoAnimalController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController racaController = TextEditingController();
  TextEditingController sexoController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

  //FormState permite trabalhar com o estado do formulário
  final _formKey = GlobalKey<
      FormState>(); //globalKey da acesso a ela em qualquer parte da classe

  @override
  Widget build(BuildContext context) {
    String? id;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Animal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  //ALINHAR OS CAMPOS DA COLUNA Á ESQUERDA DA TELA, POR ISSO O .start
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Código do animal'),
                    const SizedBox(
                      height: 5,
                    ),
                    //CAMPO TEXTO DO FORMULARIO
                    TextFormField(
                      controller: codigoAnimalController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.orangeAccent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha o campo "Código do animal"';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Descrição'),
                    const SizedBox(
                      height: 5,
                    ),
                    //CAMPO TEXTO DO FORMULARIO
                    TextFormField(
                      controller: descricaoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.orangeAccent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha o campo descrição';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Text('Raça'),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: racaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.orangeAccent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor preencha o campo raça';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Text('Sexo'),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: sexoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.orangeAccent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor preencha o campo sexo';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Text('Peso'),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: pesoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.orangeAccent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor preencha o campo peso';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                //BOTÃO PARA SALVAR
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    AnimalServico animalServices = AnimalServico();
                    AnimalVO animal = AnimalVO(
                        id,
                        codigoAnimalController.text,
                        descricaoController.text,
                        racaController.text,
                        sexoController.text,
                        pesoController.text);
                    animalServices.addAnimal(animal);
                    Navigator.of(context)
                        .pushReplacementNamed(MyApp.dashboardScreen);
                  }
                },
                child: const Text('Salvar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
