import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curd/pages/updateStudent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class studentList extends StatefulWidget {
  @override
  State<studentList> createState() => _studentListState();
}

class _studentListState extends State<studentList> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  //For Deleting User

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> daleteUser(id) {
    //print('User Deleted $id');
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Notes',
              style: TextStyle(color: Colors.black),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.color_lens,
                      color: Colors.black,
                    ),
                    Icon(
                      Icons.view_stream,
                      color: Colors.black,
                    )
                  ],
                )
              ],
            )
          ],
        ),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data?.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: storedocs.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.all(8),
                  child: Slidable(
                    startActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          flex: 1,
                          onPressed: ((context) {
                            //call number
                          }),
                          backgroundColor: Color.fromARGB(255, 76, 99, 175),
                          icon: Icons.phone,
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          borderRadius: BorderRadius.circular(10),
                          flex: 1,
                          onPressed: (context) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateStudentPage(
                                    id: storedocs[index]['id']),
                              ),
                            );
                          },
                          backgroundColor: Colors.green,
                          icon: Icons.edit,
                        ),
                        SlidableAction(
                          borderRadius: BorderRadius.circular(10),
                          onPressed: ((context) {
                            //call delete
                            daleteUser(storedocs[index]['id']);
                          }),
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        title: Text("${storedocs[index]['name']}"),
                        subtitle: Text("${storedocs[index]['email']}"),
                      ),
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
