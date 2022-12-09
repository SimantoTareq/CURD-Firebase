import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class slidable extends StatefulWidget {
  const slidable({super.key});

  @override
  State<slidable> createState() => _slidableState();
}

class _slidableState extends State<slidable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Slidable(
          startActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                flex: 1,
                onPressed: ((context) {
                  //call number
                }),
                backgroundColor: Colors.green,
                icon: Icons.phone,
              ),
              SlidableAction(
                flex: 2,
                onPressed: ((context) {
                  //text number
                }),
                backgroundColor: Colors.blue,
                icon: Icons.message,
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: ((context) {
                  //call delete
                }),
                backgroundColor: Colors.red,
                icon: Icons.delete,
              ),
            ],
          ),
          child: Container(
            color: Colors.grey[300],
            child: ListTile(
              title: Text('Simanto Tareq'),
              subtitle: Text('0162821'),
              leading: Icon(
                Icons.person,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
