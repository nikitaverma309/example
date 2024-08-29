import 'dart:convert';

import 'package:collection/collection.dart';

class Student {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? division;
  String? studentClass;
  String? address;
  String? dob;
  DateTime? createdAt;
  DateTime? updatedAt;

  Student({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.division,
    this.studentClass,
    this.address,
    this.dob,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Student(id: $id, name: $name, email: $email, phone: $phone, division: $division, studentClass: $studentClass, address: $address, dob: $dob, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Student.fromMap(Map<String, dynamic> data) => Student(
        id: data['id'] as int?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        division: data['division'] as String?,
        studentClass: data['class'] as String?,
        address: data['address'] as String?,
        dob: data['dob'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'division': division,
        'class': studentClass,
        'address': address,
        'dob': dob,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Student].
  factory Student.fromJson(String data) {
    return Student.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Student] to a JSON string.
  String toJson() => json.encode(toMap());

  Student copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? division,
    String? studentClass,
    String? address,
    String? dob,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      division: division ?? this.division,
      studentClass: studentClass ?? this.studentClass,
      address: address ?? this.address,
      dob: dob ?? this.dob,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Student) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      division.hashCode ^
      studentClass.hashCode ^
      address.hashCode ^
      dob.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
