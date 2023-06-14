class Goals {
  final String? id;
  final String name;
  final double value;
  final String userId;

  const Goals({
    this.id,
    required this.name,
    required this.value,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
    };
  }

  factory Goals.fromMap(Map<String, dynamic> map) {
    return Goals(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      userId: map['userId'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, value: $value, userId: $userId}';
  }
}