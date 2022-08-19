
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class VendorNetwork {
  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiMjEyNjc2ZWYwMzE4OGM3MzQwNDdjNzE1YjFhZTdjMGEzYmZmN2IyZjU0NjA2NjQ5ZmI0ODFmNDQzNWYwZmFhMDUxNmVjODU3OWQ4MmY4ZTkiLCJpYXQiOjE2NjA4ODYwNzIuODg0Mjg4LCJuYmYiOjE2NjA4ODYwNzIuODg0MjkyLCJleHAiOjE2NjIxODIwNzIuODc1MTcyLCJzdWIiOiIyIiwic2NvcGVzIjpbIioiXX0.bzG4Vx8FPW7GKqDvsyvaWP1-sldJHySSZE72nMGN6clFS9HyaN_xhcNOi0cYV0usPbzJdP4lfv7bBpzrxT2aHTgepMkZ-SBmG3_wdcPXgvW5DdbJ-ZhrHMLFB12Udt9RiTTyy46sr63OcJj9t-_w8a4kKfgepgFJUqwtZOLtUM85mkzx-LGgE4da6pXfIAYFRdVoFjA-YPRw079iqfsBnX18K-OV1uWLx3TfFDzUn3Az3W7bpeqWN7VUTZdEGWIzUF-kjBgvz2h5HXiMUj-Kz3ScQQPGUSDYM49V27BCE11O9dbPYBlxzTzhSfxr9ZNleAoURFjC6jz8QOdHBvTK6e540fF0J9SoDyr757fJPDREpdoKOCsWagknVnTY4pnmk5j3RD_WBM3LghJf7g9PtLjrI24CuH2Qoc-BWlTBTgT0pr2NZqqoud84zfL5UTvBP5OVQ53xAZandc31Am1Ukzd9TpT26qhzEQT01z8vmVKyvI3wGIO2MgGHjyJVjgglDJO7gPDEgM0rIVOPfKkhq6D7AYPCPnwY_E2trz0u6bSwdWJ-LZohjAruQoxhmDy3PWIeKUrtWn3pi5t2OPLKHdFaxwBjw2iuqymo7ACl-rwPBKlDE7S-VlelQIt3MeBNPIjJIapsoFqNl-Mg0PiphMgWWMeMrGl8JodkX5ELQ5g'
  };
  Future<Iterable<dynamic>> getCariItem(keyword) async {
    var full_url = 'https://dev.softbridge.id/api/iv/stockbarcode?syscode=${keyword}&status=1';
    final res = await http.get(Uri.parse(full_url), headers: _setHeaders());

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      print(json);
      print(full_url);
      var data = json['items'];
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }


}