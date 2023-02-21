import 'dart:math';

import 'package:flutter/material.dart';

import '../../theme/color_theme.dart';
import 'global_widgets.dart';

// ignore: must_be_immutable
class TileHistory extends StatelessWidget {
  TileHistory({super.key});
  final List<Map<String, dynamic>> history = List.generate(100,
      (index) => {'item': 'food #$index', 'amount': Random().nextInt(100) + 1});
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        child: ListTile(
            title: Row(
              children: [
                Text(
                  history[index]['item'],
                  style: CustomTextStyles.h2Text,
                ),
                const Spacer(),
                Text('${date.month}-${date.day}-${date.year}')
              ],
            ),
            leading: const CircleAvatar(
              child: FlutterLogo(),
            ),
            subtitle: Row(
              children: [
                Text(
                  '₹${history[index]['amount'].toString()}',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_note_sharp),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
              ],
            ),
            trailing: Icon(
              Icons.arrow_upward,
              color: ColorTheme.redColor,
            )),
      ),
    );
  }
}
