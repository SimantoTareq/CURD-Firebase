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
  //Updating Data
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future<void> updateUser(
    id,
    title,
    note_content,
  ) {
    return students.doc(id).update({
      'title': title,
      'note_content': note_content,
    });
  }

  String date = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Student"),
      ),
      body: newMethod(),
    );
  }

  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>> newMethod() {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
        var title = data!['title'];
        var note_content = data['note_content'];

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Title',
                ),
                initialValue: title,
                autofocus: false,
                onChanged: (value) => title = value,
                style: Appstyle.mainTitle,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                date,
                style: Appstyle.dateTitle,
              ),
              SizedBox(
                height: 28.0,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Content',
                ),
                initialValue: note_content,
                autofocus: false,
                onChanged: (value) => note_content = value,
                style: Appstyle.mainContent,
              ),
            ],
          ),
        );
      },
    );
  }
}
