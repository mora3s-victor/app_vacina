import 'package:app_vacina_animal/models/vo/animal_vo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnimalServico {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //persiste no firebase
  addAnimal(AnimalVO animalVO) {
    _firestore.collection('Animais').add(animalVO.toMap());
  }

  //Devemos definir o tipo de retorno de acordo com quem vai receber o resultado
  Stream<QuerySnapshot> getAnimais() {
    CollectionReference collectionAnimais = _firestore.collection('Animais');
    return collectionAnimais.snapshots();
  }

  deletarAnimal(String id) {
    DocumentReference docRef = _firestore.collection('Animais').doc(id);
    docRef
        .delete()
        .whenComplete(() => debugPrint("Dados do $id deletado com sucesso!!"))
        .catchError((erro) => debugPrint("Erro ao deletar o $id -> $erro!!"));
  }

  atualizarAnimal(AnimalVO animal) {
    DocumentReference docRef = _firestore.collection('Animais').doc(animal.id);
    docRef
        .update(animal.toMap())
        .whenComplete(
            () => debugPrint("Dados do ${animal.id} deletado com sucesso!!"))
        .catchError(
            (erro) => debugPrint("Erro ao deletar o ${animal.id} -> $erro!!"));
  }
}
