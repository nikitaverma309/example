import 'dart:convert';

import 'package:collection/collection.dart';

import 'student.dart';

class StudentResponse {
  List<Student>? students;

  StudentResponse({this.students});

  @override
  String toString() => 'StudentResponse(students: $students)';

  factory StudentResponse.fromMap(Map<String, dynamic> data) {
    return StudentResponse(
      students: (data['students'] as List<dynamic>?)
          ?.map((e) => Student.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'students': students?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StudentResponse].
  factory StudentResponse.fromJson(String data) {
    return StudentResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StudentResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  StudentResponse copyWith({
    List<Student>? students,
  }) {
    return StudentResponse(
      students: students ?? this.students,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! StudentResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => students.hashCode;
}
