class AnimalVO {
  String? id;
  String? codigo;
  String? descricao;
  String? raca;
  String? peso;
  String? sexo;

  AnimalVO(
      this.id, this.codigo, this.descricao, this.raca, this.sexo, this.peso);

//Converte os dados recuperados do banco em formato Json  para objeto.
  AnimalVO.fromMap(Map<String, dynamic> map)
      : codigo = map['codigo'],
        descricao = map['descricao'],
        raca = map['raca'],
        sexo = map['sexo'],
        peso = map['peso'];

  //Converte para json para que possamos persistir as informações no Firebase
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'raca': raca,
      'sexo': sexo,
      'peso': peso,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnimalVO &&
        other.codigo == codigo &&
        other.descricao == descricao &&
        other.raca == raca &&
        other.peso == peso &&
        other.sexo == sexo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        codigo.hashCode ^
        descricao.hashCode ^
        raca.hashCode ^
        peso.hashCode ^
        sexo.hashCode;
  }
}
