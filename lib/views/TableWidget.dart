import 'package:flutter/material.dart';
import 'package:spending_app/modal/Items.dart';

class TableWidget extends StatefulWidget {
  final List<Items> itemList;
  const TableWidget(
    this.itemList, {
    Key key,
  }) : super(key: key);

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: [
          DataColumn(label: Text("Item")),
          DataColumn(label: Text("Cost")),
          DataColumn(label: Text("Date"))
        ],
        rows: widget.itemList
            .map((elem) => DataRow(cells: [
                  DataCell(Text(elem.item)),
                  DataCell(Text(elem.cost.toString())),
                  DataCell(Text(elem.date)),
                ]))
            .toList());
  }
}
