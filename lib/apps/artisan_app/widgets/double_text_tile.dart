import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DoubleTextTile extends StatelessWidget
{
  final String title;
  final String subText;
  final IconData trailingIcon;
  final bool? iconIsSvg;
  final String? svgPath;

  DoubleTextTile({
    super.key,
    required this.title,
    required this.subText,
    required this.trailingIcon,
    this.iconIsSvg,
    this.svgPath
  })
  {
    // TODO: use assertion here
    if (iconIsSvg == true && (svgPath == null))
    {
      throw Exception("Please provide svg path");
    }
  }

  Widget _buildTile()
  {
    bool svgCheck = (!(iconIsSvg == false) && (svgPath != null));
    return ListTile(
      title: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: "$title \n",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              )
            ),
            TextSpan(
              text: subText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF949494)
              )
            )
          ]
        )
      ),
      trailing: svgCheck ? SvgPicture.asset(
        "assets/svg/rounded_check.svg",
        semanticsLabel: 'profile check icon',
      ) : Icon(trailingIcon)
    );
  }

  @override
  Widget build(BuildContext context) => _buildTile();
}
