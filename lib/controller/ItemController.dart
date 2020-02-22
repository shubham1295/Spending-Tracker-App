import 'package:spending_app/modal/Items.dart';
import 'package:spending_app/modal/Main.dart';

abstract class ItemController {
  List<Items> populateData();
  Future<Main> fetchPost();
}