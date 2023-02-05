import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curd/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class noteReaderScreen extends StatefulWidget {
  final String id;
  final int cl_id;

  noteReaderScreen({super.key, required this.id, required this.cl_id});

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
    int? color_id = widget.cl_id;
    return Scaffold(
      backgroundColor: Appstyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: Appstyle.cardsColor[color_id],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        //title: Text("Update Student"),
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
        String create_date = data['creation_date'];
        //  var time = DateTime('create_date');

        return Container(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
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
                    create_date,
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
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.

                        updateUser(
                          widget.id,
                          title,
                          note_content,
                        );
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.save),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
