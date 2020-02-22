class Items {
  String sId;
  String item;
  int cost;
  String date;

  Items({this.sId, this.item, this.cost, this.date});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    item = json['item'];
    cost = json['cost'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['item'] = this.item;
    data['cost'] = this.cost;
    data['date'] = this.date;
    return data;
  }
}