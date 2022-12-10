import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class topPage extends StatefulWidget {
  const topPage({super.key});

  @override
  State<topPage> createState() => _topPageState();
}

class _topPageState extends State<topPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Row(
              children: [
                Text('Notes'),
                Row(
                  children: [
                    Icon(Icons.color_lens),
                    Icon(Icons.view_stream),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
