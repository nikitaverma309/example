import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../student_response/student.dart';
import '../student_response/student_response.dart';

class StudentRepository {
  // Private static
  int j = 10;

  // Private static instance variable
  static StudentRepository? _instance;

  // Private constructor
  StudentRepository._() {
    print("in constructor");
  }

  // Public method to access the singleton instance
  static StudentRepository get instance {
    // Create a new instance if it doesn't exist
    _instance ??= StudentRepository._();
    return _instance!;
  }

  Future<List<Student>> fetchData() async {
    var url = Uri.parse('http://192.168.1.2:8000/api/students');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      StudentResponse? studentResponse =
          StudentResponse.fromJson(response.body);

      final students = studentResponse.students ?? [];

      return students;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Student> fetchSingle({required String id}) async {
    var url = Uri.parse('http://192.168.1.2:8000/api/students/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      Student studentResponse = Student.fromMap(
          (json.decode(response.body) as Map<String, dynamic>)["student"]);

      return studentResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void addStudent({required String name, required String phone}) async {
    var url = Uri.parse('http://192.168.1.2:8000/api/students');
    //
    final student = Student(
            name: name,
            phone: phone,
            email: "emaifsdflw@gmail.com",
            address: "",
            division: "",
            dob: "")
        .toJson();
    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json", "Accept": "*/*"},
        body: student,
      );
      print(response.body);
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }
}
