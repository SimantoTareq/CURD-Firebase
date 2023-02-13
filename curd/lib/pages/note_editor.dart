import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curd/style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class noteEditorScreen extends StatefulWidget {
  const noteEditorScreen({super.key});

  @override
  State<noteEditorScreen> createState() => _noteEditorScreenState();
}

class _noteEditorScreenState extends State<noteEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  var title = "";
  var note_content = "";

  //create a text controller and use it to retrive the current  value of the TextField

  final titleController = TextEditingController();
  final mainlController = TextEditingController();
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  @override

  //Adding Data

  Future<void> addUser() {
    //print('User Added');
    return students
        .add({
          'title': title,
          'note_content': note_content,
          'creation_date': date,
          'color_id': color_id,
        })
        .then((value) => print('User added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  int color_id = Random().nextInt(Appstyle.cardsColor.length);
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: Appstyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add a new Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.red, fontSize: 15.0),
                  border: InputBorder.none,
                  hintText: 'Note Title',
                ),
                controller: titleController,
                style: Appstyle.mainTitle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter The Title';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              DateFormat.yMMM().add_jm().format(date),
              style: Appstyle.dateTitle,
            ),
            SizedBox(
              height: 28.0,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Content',
              ),
              controller: mainlController,
              style: Appstyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Appstyle.accentColor,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            setState(
              () {
                title = titleController.text;
                note_content = mainlController.text;

                addUser();
                Navigator.of(context).pop();
              },
            );
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
