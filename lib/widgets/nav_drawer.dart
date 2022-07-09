import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
        SizedBox(
        height: 150.0,
        child: DrawerHeader(
          margin: EdgeInsets.zero,
          child: Row(
              children: [
                CircleAvatar(
                    radius : 30,
                    backgroundImage: AssetImage('lib/assets/images/sample_pic.jpg')
                ),
                SizedBox(width: 5,),
                Text('Hai, Diana!', style : CustomFont.whiteMedBold)
              ]
          ),
          decoration: BoxDecoration(
              color: CustomColor.theme),
        ),
      ),
          ListTile(
            leading: Icon(CupertinoIcons.book_solid, color : CustomColor.theme),
            title: Text('How we work', style : CustomFont.orangeMedBold),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.bookmark, color : CustomColor.theme),
            title: Text('Bookmark', style : CustomFont.orangeMedBold),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.square_list_fill, color : CustomColor.theme),
            title: Text('Tentang BWI', style : CustomFont.orangeMedBold),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.question_circle_fill, color : CustomColor.theme),
            title: Text('FAQ', style : CustomFont.orangeMedBold),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color : CustomColor.theme),
            title: Text('Logout', style : CustomFont.orangeMedBold),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}