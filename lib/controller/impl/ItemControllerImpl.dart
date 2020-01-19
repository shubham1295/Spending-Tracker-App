import 'package:spending_app/controller/ItemController.dart';
import 'package:spending_app/modal/Items.dart';

class ItemControllerImpl implements ItemController {
  @override
  List<Items> populateData() {
    List<Items> item = new List<Items>();
    Items itm = new Items();

    itm.id = "1";
    itm.cost = "100";
    itm.item = "Thali";
    itm.date = "1/1/20";

    item.add(itm);

    //TODO make a map of all return from API and return the map
    return item;
  }
}
