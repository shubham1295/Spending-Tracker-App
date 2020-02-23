import 'package:spending_app/controller/ItemController.dart';
import 'package:spending_app/modal/Category.dart';
import 'package:spending_app/modal/Items.dart';
import 'package:spending_app/modal/Main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemControllerImpl implements ItemController {
  @override
  List<Items> populateData() {
    // List<Items> item = new List<Items>();
    // Items itm = new Items();

    // itm.id = "1";
    // itm.cost = "100";
    // itm.item = "Thali";
    // itm.date = "1/1/20";

    // item.add(itm);

    // //TODO make a map of all return from API and return the map
    // return item;
  }

  @override
  Future<Main> fetchPost() async {
    Main main = new Main();
    var body;
    try {
      final response = await http
          .get('https://spending-tra-api-for-fl-a44vje.herokuapp.com/test');

      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON.
        body = jsonDecode(response.body);
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
    } catch (e) {
      throw Exception("No Internet");
      // add Offline page here
    }

    if (null != body) {
      main.item = (body["item"] as List)
          .map((data) => new Items.fromJson(data))
          .toList();

      main.category = (body["category"] as List)
          .map((data) => new Category.fromJson(data))
          .toList();

      main.month = body["month"];
      main.total = body["total"];
      main.year = body["year"];

      return main;
    } else {
      return null;
    }
  }
}
