import 'package:app_vacina_animal/animais/vo/animal_vo.dart';
import 'package:app_vacina_animal/aplicador/vo/aplicador_vo.dart';
import 'package:app_vacina_animal/vacinas/vo/vacina_vo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
CollectionReference collectionAnimais = _firestore.collection('Animais');

class AplicarVacinaService {
  registrarVacina(AnimalVO animal, AplicadorVO aplicador, VacinaVO vacina,
      String dataAplic) {
    DocumentReference docAnimal = collectionAnimais.doc(animal.id);

    Map<String, dynamic> vacinaEaplicador = vacina.toMap();
    vacinaEaplicador.addAll(aplicador.toMap());
    vacinaEaplicador.addAll({'Data_aplicacao': dataAplic});
    docAnimal.collection('Vacinas').add(vacinaEaplicador);

    docAnimal.collection('VacinasPendentes').doc(vacina.id).delete();
  }

  deletarVacinaAplicada(AnimalVO animal, VacinaVO vacina) {
    DocumentReference docAnimal = collectionAnimais.doc(animal.id);
    docAnimal.collection('VacinasPendentes').add(vacina.toMap());
    docAnimal.collection('Vacinas').doc(vacina.id).delete();
  }
}
