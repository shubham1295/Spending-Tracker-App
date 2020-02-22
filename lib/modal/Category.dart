class Category {
  String category;

  Category({this.category});

  Category.fromJson(Map<String, dynamic> json) {
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    return data;
  }
}