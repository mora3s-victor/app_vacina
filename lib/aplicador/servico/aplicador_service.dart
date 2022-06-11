import 'package:app_vacina_animal/aplicador/vo/aplicador_vo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
CollectionReference collectionAplicadores =
    _firestore.collection('Aplicadores');

class AplicadorService {
  getAplicadores() {
    return collectionAplicadores.snapshots();
  }

  deletarAplicador(String id) {
    DocumentReference docRef = collectionAplicadores.doc(id);
    docRef
        .delete()
        .whenComplete(() => debugPrint("Dados do $id deletado com sucesso!!"))
        .catchError((erro) => debugPrint("Erro ao deletar o $id -> $erro!!"));
  }

  atualizarAplicador(AplicadorVO aplicador) {
    DocumentReference docRef = collectionAplicadores.doc(aplicador.id);
    docRef
        .update(aplicador.toMap())
        .whenComplete(() =>
            debugPrint("Dados do ${aplicador.id} atualizado com sucesso!!"))
        .catchError((erro) =>
            debugPrint("Erro ao atualizar o ${aplicador.id} -> $erro!!"));
  }

  addAplicador(AplicadorVO aplicador) {
    collectionAplicadores.add(aplicador.toMap());
  }
}
