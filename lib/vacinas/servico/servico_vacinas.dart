// ignore_for_file: unused_local_variable

import 'package:app_vacina_animal/animais/vo/animal_vo.dart';
import 'package:app_vacina_animal/vacinas/vo/vacina_vo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore =
    FirebaseFirestore.instance; //obtem uma instancia do firebase

CollectionReference collectionAnimais = _firestore.collection("Animais");
CollectionReference collectionVacinas = _firestore.collection("Vacinas");

class ServicosVacina {
  //Listar todas vacinas aplicadas no animal
  Stream<QuerySnapshot> getVacinas(AnimalVO animal) {
    CollectionReference vacinasCollection =
        collectionAnimais.doc(animal.id).collection('Vacinas');

    return vacinasCollection.snapshots();
  }

  Stream<QuerySnapshot> getVacinasPendentes(AnimalVO animal) {
    CollectionReference vacinasPendentes =
        collectionAnimais.doc(animal.id).collection('VacinasPendentes');

    return vacinasPendentes.snapshots();
  }

  //Listar todas as vacinas os animais devem receber ao longo do ano
  Stream<QuerySnapshot> getEstoqueVacina() {
    return collectionVacinas.snapshots();
  }

  deletarVacina(String id) {
    DocumentReference docRef = _firestore.collection('Vacinas').doc(id);
    docRef
        .delete()
        .whenComplete(() => debugPrint("Dados do $id deletado com sucesso!!"))
        .catchError((erro) => debugPrint("Erro ao deletar o $id -> $erro!!"));
  }

  atualizarVacina(VacinaVO vacina) {
    DocumentReference docRef = _firestore.collection('Vacinas').doc(vacina.id);
    docRef
        .update(vacina.toMap())
        .whenComplete(
            () => debugPrint("Dados do ${vacina.id} atualizado com sucesso!!"))
        .catchError(
            (erro) => debugPrint("Erro ao deletar o ${vacina.id} -> $erro!!"));
  }

  addVacina(VacinaVO vacinaVO) async {
    collectionVacinas.add(vacinaVO.toMap());

    var animais = await collectionAnimais.get();

    CollectionReference cr;
    for (var doc in animais.docs) {
      cr = collectionAnimais.doc(doc.id).collection('VacinasPendentes');
      cr.add(vacinaVO.toMap());
    }
  }
}
