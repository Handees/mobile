import 'package:flutter/material.dart';
import '../../widgets/double_text_tile.dart';
import 'consts.dart';


class EditProfileOptions extends StatelessWidget
{
  const EditProfileOptions({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.all(5.0),
              alignment: const Alignment(-1.0, 0.0),
              child: GestureDetector(
                onTap: () { Navigator.pop(context) ;},
                child: const Icon(Icons.arrow_back)
              ),
            ),
            const EditProfileOptionItems()
          ]
          )
        ),
      )
    );
  }
}


class EditProfileOptionItems extends StatelessWidget
{
  const EditProfileOptionItems({super.key});

  Widget _buildRow(String optionName, String defaultValue)
  {
    return DoubleTextTile(
      title: optionName,
      subText: defaultValue,
      trailingIcon: Icons.arrow_forward_ios,
      iconIsSvg: false
    );
  }

  Widget _buildList()
  {
    return Expanded(
      child: ListView.separated(
        itemCount: editProfileOptionsRef.length,
        padding: const EdgeInsets.fromLTRB(
          0.0, 40, 0.0, 10.0
        ),
        itemBuilder: (BuildContext context, int index) {
          String key = editProfileOptionsRef.keys.elementAt(index);
          String val = editProfileOptionsRef[key];
          return InkWell(
            child: _buildRow(key, val),
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(color: Colors.transparent, height: 30,);
        },
      )
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return _buildList();
  }
}