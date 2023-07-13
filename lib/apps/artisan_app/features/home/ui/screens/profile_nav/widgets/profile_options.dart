import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../consts.dart';


class ProfileOptions extends StatelessWidget
{
  const ProfileOptions({super.key});

  Widget _buildRow(String optionName, String defaultValue)
  {
    return ListTile(
      title: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: "$defaultValue \n",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              )
            ),
            TextSpan(
              text: optionName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF949494)
              )
            )
          ]
        )
      ),
      trailing: SvgPicture.asset(
        "assets/svg/rounded_check.svg",
        semanticsLabel: 'profile check icon',
      )
    );
  }

  Widget _buildList()
  {
    return Expanded(
      child: ListView.separated(
        itemCount: profileOptionsList.length,
        padding: const EdgeInsets.fromLTRB(
          0.0, 40, 0.0, 10.0
        ),
        itemBuilder: (BuildContext context, int index) {
          String key = profileOptionsList.keys.elementAt(index);
          String val = profileOptionsList[key];
          return _buildRow(key, val);
        },
        separatorBuilder: (context, index) {
          return const Divider(color: Colors.transparent, height: 20,);
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) => _buildList();
}

