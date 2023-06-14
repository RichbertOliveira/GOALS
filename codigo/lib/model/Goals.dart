class Goals {
  final int id;
  final String name;
  final double value;
  final String type;
  final int userId;

  const Goals({
    required this.id,
    required this.name,
    required this.value,
    required this.type,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'type': type,
      'userId': userId,
    };
  }

  factory Goals.fromMap(Map<String, dynamic> map) {
    return Goals(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      type: map['type'],
      userId: map['userId'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, value: $value, type: $type, userId: $userId}';
  }
}