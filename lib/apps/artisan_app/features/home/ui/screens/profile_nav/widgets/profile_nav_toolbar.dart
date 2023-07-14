import 'package:flutter/material.dart';
import '../consts.dart';


class ProfileToolBar
{

  final borderSide = const BorderSide(width: 0.5, color: Color(0xFFEAEAEA));

  Widget _buildRow(IconData icon, String option, bool addBorder)
  {
    return Container(
      decoration: BoxDecoration(
        border: addBorder ? Border(bottom: borderSide) : null
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child:Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                2,0,10,0
              ),
              child: Icon(icon),
            ),
            Text(
              option,
              style: const TextStyle(
                fontSize: 14.0
              )
            )
          ]
        )
      )
    );
  }

  List<Widget> buildList()
  {
    var list = <Widget>[];
    int count = 0;

    // add more options to profileToolBarrList to extend
    profileToolBarList.forEach((key, value) {
      count++;
      if (count != profileToolBarList.length)
      {
        list.add(_buildRow(key, value, true));
      }
      else {
        list.add(_buildRow(key, value, false));
      }
    });

    return list;
  }
}