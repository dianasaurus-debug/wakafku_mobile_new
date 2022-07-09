import 'package:final_project_mobile/models/category.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(this.category);

  @required
  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          // Route route = MaterialPageRoute(builder: (context) => IndexCategory());
          // Navigator.push(context, route);
        },
        child : Container(
            margin: EdgeInsets.only(left: 15, bottom: 15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: CustomColor.themeMuted,
                borderRadius : BorderRadius.circular(10.0)
            ),
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.building, size: 50),
                SizedBox(height: 8),
                Text(category.name, style: CustomFont.blackMedBold,)
              ],
            )
        )
    );
  }
}
