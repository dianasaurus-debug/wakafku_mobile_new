import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final Widget title;
  final Widget content;

  Accordion(this.title, this.content);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -2),
            title: widget.title,
            trailing: IconButton(
              icon: Icon(
                  _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              onPressed: () {
                setState(() {
                  _showContent = !_showContent;
                });
              },
            ),
          ),
          _showContent
              ? Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: widget.content,
          )
              : Container()
        ]);
  }
}