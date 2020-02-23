import 'package:spending_app/modal/Items.dart';
import 'package:spending_app/modal/Category.dart';

class Main {
  String total;
  List<Items> item;
  String month;
  int year;
  List<Category> category;

  Main({this.total, this.item, this.month, this.year, this.category});

  Main.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['item'] != null) {
      item = new List<Items>();
      json['item'].forEach((v) {
        item.add(new Items.fromJson(v));
      });
    }
    month = json['month'];
    year = json['year'];
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['total'] = this.total;
    if (this.item != null) {
      data['item'] = this.item.map((v) => v.toJson()).toList();
    }
    // data['month'] = this.month;
    // data['year'] = this.year;
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    return data;
  }
}