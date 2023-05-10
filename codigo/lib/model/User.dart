class User {
  final int id;
  final String name;
  final String email;
  final String password;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      password: map['password'],
      email: map['email'],
    );
  }


  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password}';
  }
}