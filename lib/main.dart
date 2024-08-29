import 'dart:io';

import 'package:example/repository/student_repo.dart';
import 'package:flutter/material.dart';
import 'student_response/student.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const FLutterApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class FLutterApp extends StatelessWidget {
  const FLutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // web me
  //
  List<Student> students = [];

  // student [1,2,3] newStudent [1,2,3,4]

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 10), () async {
      students = await StudentRepository.instance.fetchData();
      students = [
        ...students,
        await StudentRepository.instance.fetchSingle(id: "1"),
      ];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: Text("${students[index].id}"),
            title: Text("${students[index].name}"),
          ),
        ),
        itemCount: students.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AddNewStudentScreen()));
        },
        tooltip: 'add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddNewStudentScreen extends StatefulWidget {
  const AddNewStudentScreen({super.key});

  @override
  State<AddNewStudentScreen> createState() => _AddNewStudentScreenState();
}

class _AddNewStudentScreenState extends State<AddNewStudentScreen> {
  final nameController = TextEditingController();
  final phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Name",
              ),
            ),
            TextField(
              controller: phoneNoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Phone",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                
                StudentRepository.instance.addStudent(name:nameController.text, phone:phoneNoController.text);
              },
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
