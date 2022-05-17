class AnimalVO {
  String? id;
  String? codigo;
  String? descricao;
  String? raca;
  String? peso;
  String? sexo;

  AnimalVO(this.codigo, this.descricao, this.raca, this.sexo, this.peso,
      {String? id});

//Converte os dados recuperados do banco em formato Json  para objeto.
  AnimalVO.fromMap(Map<String, dynamic> map)
      : codigo = map['codigo'],
        descricao = map['descricao'],
        raca = map['raca'],
        sexo = map['sexo'],
        peso = map['peso'],
        id = map['id'];
  //Converte para json para que possamos persistir as informações no Firebase
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'raca': raca,
      'sexo': sexo,
      'peso': peso,
      'id': id
    };
  }
}
