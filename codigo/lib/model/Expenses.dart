class Expenses {
  final int id;
  final String name;
  final double value;
  final String type;
  final int userId;
  final String frequency;

  const Expenses({
    required this.id,
    required this.name,
    required this.value,
    required this.type,
    required this.userId,
    required this.frequency,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'type': type,
      'frequency': frequency,
      'userId': userId,
    };
  }

  factory Expenses.fromMap(Map<String, dynamic> map) {
    return Expenses(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      type: map['type'],
      frequency: map['frequency'],
      userId: map['userId'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, value: $value, type: $type, userId: $userId, frequency: $frequency}';
  }
}