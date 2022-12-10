import 'package:curd/pages/addStudent.dart';
import 'package:curd/pages/listStudent.dart';
import 'package:curd/pages/listStudent2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: studentList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffFFB347),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (builder) => AddStudentPage()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
