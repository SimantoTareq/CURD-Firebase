import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curd/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class noteReaderScreen extends StatefulWidget {
  final String id;
  noteReaderScreen({super.key, required this.id});

  @override
  State<noteReaderScreen> createState() => _noteReaderScreenState();
}

class _noteReaderScreenState extends State<noteReaderScreen> {
  final _formKey = GlobalKey<FormState>();

  //Updating Data
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future<void> updateUser(id, name, email, password) {
    return students
        .doc(id)
        .update({'name': name, 'email': email, 'password': password});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Student"),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('students')
            .doc(widget.id)
            .get(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            print('Something Went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data!.data();
          var name = data!['name'];
          var email = data['email'];
          var password = data['password'];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                Text(name),
              ],
            ),
          );
        },
      ),
    );
  }
}
