class AplicadorVO {
  String id;
  String nome;

  AplicadorVO(
    this.id,
    this.nome,
  );

  AplicadorVO.fromMap(Map<String, dynamic> map)
      : nome = map['nome_aplicador'],
        id = map['id_aplicador'];

  Map<String, dynamic> toMap() {
    return {'id_aplicador': id, 'nome_aplicador': nome};
  }
}
