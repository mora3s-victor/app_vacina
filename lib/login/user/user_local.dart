class UserLocal {
  String? id;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;

  UserLocal({
    this.id,
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword
    };
  }

//factory indica que esse metodo é uma fabrica, assim ela pode retornar o objeto userLocal
  factory UserLocal.fromMap(Map<String, dynamic> map) {
    return UserLocal(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        password: map['password'],
        confirmPassword: map['confirmPassword']);
  }
}
