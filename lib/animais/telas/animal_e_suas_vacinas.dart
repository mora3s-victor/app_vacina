import 'package:app_vacina_animal/animais/vo/animal_vo.dart';
import 'package:app_vacina_animal/vacinas/telas/caixa_dialogo_cadastrar_vacina.dart';
import 'package:app_vacina_animal/vacinas/telas/vacinas_aplicadas.dart';
import 'package:app_vacina_animal/vacinas/telas/vacinas_pendentes.dart';
import 'package:flutter/material.dart';

class AnimalVacinasAplicadas extends StatefulWidget {
  final AnimalVO animal;

  const AnimalVacinasAplicadas({required this.animal, Key? key})
      : super(key: key);

  @override
  State<AnimalVacinasAplicadas> createState() => _AnimalVacinasAplicadasState();
}

class _AnimalVacinasAplicadasState extends State<AnimalVacinasAplicadas> {
  var codigoAnimalController = TextEditingController();
  var descricaoController = TextEditingController();
  List<String> myList = ['Vacinas Aplicadas', 'Vacinas Pendentes'];
  @override
  void initState() {
    super.initState();
    codigoAnimalController.text = widget.animal.codigo!;
    descricaoController.text = widget.animal.descricao!;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vacinas aplicadas"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Card(
                  child: Column(
                    children: [
                      const Text(
                        'Codigo do Animal ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        enabled: false,
                        //É O CONTROLLER QUE ESTÁ PERMITINDO A EXIBIÇÃO DO CODIGO DO ANIMAL NA TELA
                        controller: codigoAnimalController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Descrição',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        enabled: false,
                        //É O CONTROLLER QUE ESTÁ PERMITINDO A EXIBIÇÃO DO CODIGO DO ANIMAL NA TELA
                        controller: descricaoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 300,
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: DefaultTabController(
                      length: myList.length,
                      child: Scaffold(
                        appBar: AppBar(
                          toolbarHeight: 1,
                          automaticallyImplyLeading: false,
                          bottom: TabBar(
                            tabs: myList.map(
                              (e) {
                                return Tab(
                                  text: e.toString(),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        body: TabBarView(
                          children: [
                            Center(
                                child: VacinasAplicadas(
                              animal: widget.animal,
                            )),
                            Center(
                              child: VacinasPendentes(animal: widget.animal),
                            ),
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  abrirDialogoRegistrarVacina() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CaixaDialogoCadastrarVacina(animal: widget.animal);
        });
  }
}

/**
 * import 'package:app_vacina_animal/models/vo/animal_vo.dart';
import 'package:app_vacina_animal/telas/vacinas/caixa_dialogo_cadastrar_vacina.dart';
import 'package:app_vacina_animal/telas/vacinas/servico_vacinas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AnimalVacinasAplicadas extends StatefulWidget {
  final AnimalVO animal;

  const AnimalVacinasAplicadas({required this.animal, Key? key})
      : super(key: key);

  @override
  State<AnimalVacinasAplicadas> createState() => _AnimalVacinasAplicadasState();
}

class _AnimalVacinasAplicadasState extends State<AnimalVacinasAplicadas> {
  var codigoAnimalController = TextEditingController();
  var descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    codigoAnimalController.text = widget.animal.codigo!;
    descricaoController.text = widget.animal.descricao!;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ServicosVacina service = ServicosVacina();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vacinas aplicadas"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Card(
                  child: Column(
                    children: [
                      const Text(
                        'Codigo do Animal ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        enabled: false,
                        //É O CONTROLLER QUE ESTÁ PERMITINDO A EXIBIÇÃO DO CODIGO DO ANIMAL NA TELA
                        controller: codigoAnimalController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Descrição',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        enabled: false,
                        //É O CONTROLLER QUE ESTÁ PERMITINDO A EXIBIÇÃO DO CODIGO DO ANIMAL NA TELA
                        controller: descricaoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 8, right: 8, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Vacinas Aplicadas',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            abrirDialogoRegistrarVacina();
                          },
                          child: const Text('Nova Vacina')),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 280,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: service.getVacinas(widget.animal),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data != null) {
                        final docs = data.docs;
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                tileColor:
                                    const Color.fromARGB(255, 216, 222, 228),
                                title: Text(
                                  docs[index].get('nome'),
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
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6),
                                    Text(
                                        '\n Aplicador: ${docs[index].get('nomeAplicador')}'),
                                  ],
                                ),
                                trailing: CircleAvatar(
                                  backgroundColor: Colors.orange[400],
                                  foregroundColor: Colors.white,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    // ignore: avoid_returning_null_for_void
                                    onPressed: () {
                                      //service.deletarAnimal(docs[index].id);
                                      Fluttertoast.showToast(
                                        msg: "Animal excluído com Sucesso!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor:
                                            const Color(0x55000000),
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
                      else if (snapshot.connectionState ==
                          ConnectionState.done) {
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
              )
            ],
          ),
        ),
      ),
    );
  }

  abrirDialogoRegistrarVacina() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CaixaDialogoCadastrarVacina(animal: widget.animal);
        });
  }
}

 */