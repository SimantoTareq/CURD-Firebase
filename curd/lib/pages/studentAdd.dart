import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class studentAdd extends StatefulWidget {
  const studentAdd({super.key});

  @override
  State<studentAdd> createState() => _studentAddState();
}

class _studentAddState extends State<studentAdd> {
  final _formKey = GlobalKey<FormState>();
  var name = "";
  var email = "";
  var password = "";
  //create a text controller and use it to retrive the current  value of the TextField

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> addUser() {
    //print('User Added');
    return students
        .add({'name': name, 'email': email, 'password': password})
        .then((value) => print('User added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Color(0xffFFB347),
                      size: 24,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Add Note',
                      style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.more_vert,
                      size: 24,
                    ),
                  ],
                )
              ],
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: "Title",
                labelStyle: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000)),
              ),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: "Type something...",
                labelStyle: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.green[300],
        icon: Icon(Icons.save),
        label: Text("Save"),
      ),
    );
  }
}
