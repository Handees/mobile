import 'package:flutter/material.dart';
import '../../../consts.dart';


class ProfileToolBarItem extends StatelessWidget
{
  final IconData icon;
  final String option;
  final bool addBorder;
  final Widget onClickAction;
  final borderSide = const BorderSide(width: 0.5, color: Color(0xFFEAEAEA));

  const ProfileToolBarItem(
    {
      super.key,
      required this.icon,
      required this.addBorder,
      required this.onClickAction,
      required this.option
    }
  );

  @override
  Widget build(BuildContext context)
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
}


class ProfileToolBar
{

  final borderSide = const BorderSide(width: 0.5, color: Color(0xFFEAEAEA));

  ProfileToolBarItem _buildRow(IconData icon, String option, bool addBorder, Widget action)
  {
    return ProfileToolBarItem(
      icon: icon,
      addBorder: addBorder,
      onClickAction: action,
      option: option
    );
  }

  List<ProfileToolBarItem> buildList()
  {
    var list = <ProfileToolBarItem>[];
    int count = 0;

    // add more options to profileToolBarrList to extend
    profileToolBarList.forEach((key, value) {
      count++;
      String option = value["option"];
      Widget action = value["action"];
      if (count != profileToolBarList.length)
      {
        list.add(_buildRow(key, option, true, action));
      }
      else {
        list.add(_buildRow(key, option, false, action));
      }
    });

    return list;
  }
}
