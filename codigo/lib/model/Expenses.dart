class Expenses {
  final int id;
  final String name;
  final double value;
  final String type;
  final int userId;

  const Expenses({
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

  @override
  String toString() {
    return 'User{id: $id, name: $name, value: $value, type: $type, userId: $userId}';
  }
}