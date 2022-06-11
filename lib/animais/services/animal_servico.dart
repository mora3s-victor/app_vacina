import 'package:app_vacina_animal/vacinas/vo/vacina_vo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../vo/animal_vo.dart';

final FirebaseFirestore _firestore =
    FirebaseFirestore.instance; //obtem uma instancia do firebase
CollectionReference collectionVacinas = _firestore.collection('Vacinas');
CollectionReference collectionAnimais = _firestore.collection("Animais");

class AnimalServico {
  atualizarAnimal(AnimalVO animal) {
    DocumentReference docRef = _firestore.collection('Animais').doc(animal.id);
    docRef
        .update(animal.toMap())
        .whenComplete(
            () => debugPrint("Dados do ${animal.id} atualizado com sucesso!!"))
        .catchError(
            (erro) => debugPrint("Erro ao deletar o ${animal.id} -> $erro!!"));
  }

  //METODO PARA PERSISTIR UM ANIMAL NO FIREBASE
  addAnimal(AnimalVO animalVO) async {
    collectionAnimais.add(animalVO.toMap());

    var result = await collectionAnimais.get();
    var vacinas = await collectionVacinas.get();

    for (var doc in result.docs) {
      if (animalVO.codigo == doc['codigo']) {
        animalVO.id = doc.id;
      }
    }

    for (var doc in vacinas.docs) {
      VacinaVO vacina = VacinaVO(doc['id_vacina'], doc['nome_vacina']);
      collectionAnimais
          .doc(animalVO.id)
          .collection('VacinasPendentes')
          .add(vacina.toMap());
    }
  }

  //BUSCA TODOS OS ANIMAIS NO FIREBASE
  //Devemos definir o tipo de retorno de acordo com quem vai receber o resultado
  Stream<QuerySnapshot> getAnimais() {
    return collectionAnimais.snapshots();
  }

  deletarAnimal(String id) {
    DocumentReference docRef = _firestore.collection('Animais').doc(id);
    docRef
        .delete()
        .whenComplete(() => debugPrint("Dados do $id deletado com sucesso!!"))
        .catchError((erro) => debugPrint("Erro ao deletar o $id -> $erro!!"));
  }
}
