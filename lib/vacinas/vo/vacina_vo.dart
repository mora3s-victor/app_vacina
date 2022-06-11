class VacinaVO {
  String? id;
  String? nome;

  VacinaVO(this.id, this.nome);

  Map<String, dynamic> toMap() {
    return {'nome_vacina': nome, 'id_vacina': id};
  }

  VacinaVO.fromMap(Map<String, dynamic> map)
      : nome = map['nome_vacina'],
        id = map['id_vacina'];
}
