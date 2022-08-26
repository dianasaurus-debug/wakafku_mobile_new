import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/controllers/vendor.dart';
import 'package:final_project_mobile/screens/program/waqf_form/detail_form.dart';
import 'package:final_project_mobile/screens/program/waqf_form/form.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/widgets/app_bar.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/constants.dart';

class Coba extends StatefulWidget {
  @override
  _CobaState createState() => _CobaState();
}

class _CobaState extends State<Coba> {
  var i = 1;
  @override
  void initState() {
    super.initState();
    arrofRows.add(
      TableRow(children: [
        Column(children: [
          Text('${i}',
              style: TextStyle(fontSize: 12, color: Colors.black))
        ]),
        Column(children: [
          // input barcode
          TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: textControllers[0]['barcode'],
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), //modify outline field
                  hintText: 'Type barcode'),
            ),
            suggestionsCallback: (pattern) async {
              return await VendorNetwork().getCariItem(pattern);
            }, //ambil data dari api
            itemBuilder: (context, suggestion) {
              //nampilin list suggestion
              var suggestion_parse = (suggestion as Map);
              return ListTile(
                title: Text(suggestion_parse['make']['make']),
                // title: Text('${suggestion_parse['barcode']} ${suggestion_parse['barcodelbl']}'),
                subtitle: Text('\$${suggestion['name']}'),
              );
            },
            onSuggestionSelected: (suggestion) {
              //yg dilakukan ketika orang klik suggested item yg dipilih
              var detail_suggestion_parse = (suggestion as Map);
              textControllers[0]['barcode'].text = detail_suggestion_parse['make']['make'];
              textControllers[0]['product'].text = detail_suggestion_parse['name'];
              textControllers[0]['price'].text = detail_suggestion_parse['default_price'];
              textControllers[0]['qty'].text = detail_suggestion_parse['id'].toString();
              textControllers[0]['disc'].text = detail_suggestion_parse['discount'].toString();
              textControllers[0]['total'].text = (int.parse(textControllers[0]['qty'].text)*double.parse(detail_suggestion_parse['default_price'])).toString();
            },
          ),
        ]),
        Column(children: [
          TextField(readOnly : true, controller: textControllers[0]['product'], style: TextStyle(fontSize: 12, color: Colors.black))

        ]),
        Column(children: [
          TextField(readOnly : true, controller: textControllers[0]['price'], style: TextStyle(fontSize: 12, color: Colors.black))

        ]),
        Column(children: [
          TextField(
            controller: textControllers[0]['qty'],
            autofocus: false,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              contentPadding:
              EdgeInsets.fromLTRB(12, 10.0, 12, 10.0),
              filled: true,
              fillColor: Color(0xffb2ff59),
              border: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.white, width: 0.0)),
            ),
          )
        ]),
        Column(children: [
          TextField(readOnly : true, controller: textControllers[0]['disc'], style: TextStyle(fontSize: 12, color: Colors.black))

        ]),
        Column(children: [
          TextField(readOnly : true, controller: textControllers[0]['total'], style: TextStyle(fontSize: 12, color: Colors.black))

        ]),
        Column(children: const [
          Text('',
              style: TextStyle(fontSize: 12, color: Colors.black))
        ]),
      ]),
    );
  }
  List<dynamic> textControllers = [
    {
      'barcode' :  TextEditingController(),
      'product' :  TextEditingController(),
      'price' :  TextEditingController(),
      'qty':  TextEditingController(),
      'disc' :  TextEditingController(),
      'total' :  TextEditingController()
    }
  ];
  List<TableRow> arrofRows = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: CustomColor.themedarker, size: 25),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            GestureDetector(
              child: Icon(Icons.bookmark,
                  color: CustomColor.themedarker, size: 25),
              onTap: () => Navigator.of(context).pop(),
            ),
            IconButton(
              icon: Icon(Icons.share, color: CustomColor.themedarker, size: 25),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          elevation: 0),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Table(
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
              children: [
                TableRow(children: [
                  Column(children: const [
                    Text('No',
                        style: TextStyle(fontSize: 12, color: Colors.black))
                  ]),
                  Column(children: const [
                    Text('Barcode',
                        style: TextStyle(fontSize: 12, color: Colors.black))
                  ]),
                  Column(children: const [
                    Text('Product',
                        style: TextStyle(fontSize: 12, color: Colors.black))
                  ]),
                  Column(children: const [
                    Text('Price',
                        style: TextStyle(fontSize: 12, color: Colors.black))
                  ]),
                  Column(children: const [
                    Text('Qty',
                        style: TextStyle(fontSize: 12, color: Colors.black))
                  ]),
                  Column(children: const [
                    Text('Disc',
                        style: TextStyle(fontSize: 12, color: Colors.black))
                  ]),
                  Column(children: const [
                    Text('Total',
                        style: TextStyle(fontSize: 12, color: Colors.black))
                  ]),
                  Column(children: const [
                    Text('',
                        style: TextStyle(fontSize: 12, color: Colors.black))
                  ]),
                ]),
                for ( var i=0;i<arrofRows.length;i++ )
                  arrofRows[i]

              ])
          // child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       TypeAheadField(
          //         textFieldConfiguration: TextFieldConfiguration(
          //           autofocus: true,
          //           decoration: InputDecoration(
          //               border: OutlineInputBorder(), //modify outline field
          //               hintText: 'What is on your mind?'),
          //         ),
          //         suggestionsCallback: (pattern) async {
          //           return await VendorNetwork().getCariItem(pattern); //ambil data dari api
          //         },
          //         itemBuilder: (context, suggestion) { //nampilin list suggestion
          //           var suggestion_parse = (suggestion as Map);
          //           return ListTile(
          //             title: Text(suggestion_parse['itemcode']),
          //           );
          //         },
          //         onSuggestionSelected: (suggestion) { //yg dilakukan ketika orang klik suggested item yg dipilih
          //           var detail_suggestion_parse = (suggestion as Map);
          //           print(detail_suggestion_parse);
          //         },
          //       ),
          //     ])
          ),
    );
  }
}
