import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String id;
  final String name;
  final DateTime createdAt;

  UserEntity({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': Timestamp.fromDate(DateTime.now()),
    };
  }

  factory UserEntity.fromJson(Map<String, dynamic> map) {
    return UserEntity(
      id: map['uid'] as String,
      name: map['name'] as String,
      createdAt:(map['createdAt'] as Timestamp).toDate(),
    );
  }

  @override
  String toString() =>
      'UserEntity(id: $id, name: $name, createdAt: $createdAt)';
}
