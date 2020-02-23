import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spending_app/controller/ItemController.dart';
import 'package:spending_app/controller/impl/ItemControllerImpl.dart';
import 'dart:async';
import 'package:spending_app/modal/Main.dart';
import 'MenuDrawer.dart';
import 'TableWidget.dart';
import 'package:intl/intl.dart';

class HomeMaterial extends StatefulWidget {
  final ItemController itemController = new ItemControllerImpl();

  @override
  State<StatefulWidget> createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  final _formKey = GlobalKey<FormState>();

  String _currentValueSelected;
  String _selectedDate;

  Future<Main> futureBean;
  @override
  void initState() {
    super.initState();
    futureBean = this.widget.itemController.fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    Main mainBean = new Main();

    Future<Null> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null)
        setState(() {
          _selectedDate = new DateFormat('dd/MM/yyyy').format(picked);
        });
    }

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(title: Text("Spending Tracker")),
          body: FutureBuilder<Main>(
            future: futureBean,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              mainBean = snapshot.data;
              if (snapshot.hasData) {
                return SingleChildScrollView(child: Builder(
                  builder: (context) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 20, 0, 10),
                            child: Text("\u20B9 " + mainBean.total,
                                style: TextStyle(fontSize: 30.0)),
                          ),
                          Container(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 0, 0, 0),
                            child: Text(
                                mainBean.month + " " + mainBean.year.toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300)),
                          ),
                          Divider(
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                // Drop Down
                                buildDropdownWidget(mainBean),
                                //Item Field
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Item'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Item';
                                    }
                                    return null;
                                  },
                                  // onSaved: (val) => setState(() => _user.lastName = val) ,
                                ),
                                //Cost Field
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Cost'),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  /* validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Last Name';
                                }
                                return null;
                              }, */
                                  // onSaved: (val) => setState(() => _user.lastName = val) ,
                                ),
                                dateWidget(_selectDate, context),

                                sendButtonWidget(context)
                              ],
                            ),
                          ),
                          TableWidget(mainBean.item),
                        ],
                      ),
                    );
                  },
                ));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                  // Text('Please Wait ... '),
                ),
              );
            },
          ),
          drawer: MenuDrawer(),
        ));
  }

  DropdownButton<String> buildDropdownWidget(Main mainBean) {
    return DropdownButton<String>(
      hint: Text("Select a Catagory"),
      items: mainBean.category.map((elem) {
        return DropdownMenuItem<String>(
          value: elem.category,
          child: Text(elem.category),
        );
      }).toList(),
      onChanged: (String selectedValue) {
        setState(() {
          this._currentValueSelected = selectedValue;
        });
      },
      value: _currentValueSelected,
      isExpanded: true,
    );
  }

  Padding dateWidget(
      Future<dynamic> _selectDate(BuildContext context), BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: OutlineButton(
          onPressed: () => _selectDate(context),
          child: Align(
            alignment: Alignment.centerLeft,
            child:
                Text((null != _selectedDate) ? _selectedDate : "Select Date"),
          )),
    );
  }

  MaterialButton sendButtonWidget(BuildContext context) {
    return MaterialButton(
        child: Text('Send'),
        padding: EdgeInsets.all(15.0),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          //doSomething,
          debugPrint("Send Pressed");
        });
  }
}
