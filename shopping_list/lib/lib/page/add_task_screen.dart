import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopping_list/core/models/card.dart';
import 'package:shopping_list/core/viewmodels/card_model.dart';

import 'package:shopping_list/lib/scopedmodel/todo_list_model.dart';
import 'package:shopping_list/lib/model/task_model.dart';
import 'package:shopping_list/lib/component/iconpicker/icon_picker_builder.dart';
import 'package:shopping_list/lib/component/colorpicker/color_picker_builder.dart';
import 'package:shopping_list/lib/utils/color_utils.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen();

  @override
  State<StatefulWidget> createState() {
    return _AddTaskScreenState();
  }
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTask;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color taskColor;
  IconData taskIcon;

  String dateOfCard;
  String title;
  String description;
  String color;
  String iconicSymbol;

  addDataCard(){
    print("card creation started");

    DocumentReference docref = Firestore.instance.collection("ShoppingList").document();

    Map<String,dynamic> cardDoc = {
      "color":taskColor.value,
      "data":"testdate",
      "description":"testdescription",
      "icon":taskIcon.codePoint,
      "title":newTask
    };
    docref.setData(cardDoc).whenComplete((){
      print("card creation completed");
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      newTask = '';
      taskColor = ColorUtils.defaultColors[0];
      taskIcon = Icons.work;
    });
  }

  @override
  Widget build(BuildContext context) {

    //importing card model for firebase
   // var cardProvider = new CardCRUDModel();

    return ScopedModelDescendant<TodoListModel>(
      builder: (BuildContext context, Widget child, TodoListModel model) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'New Card',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black26),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create card for a shopping list!',
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                ),
                Container(
                  height: 16.0,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() => newTask = text);
                  },
                  cursorColor: taskColor,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Card Name...',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      )),
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 36.0),
                ),
                Container(
                  height: 26.0,
                ),
                Row(
                  children: [
                    ColorPickerBuilder(
                        color: taskColor,
                        onColorChanged: (newColor)     =>
                            setState(() => taskColor = newColor)),
                    Container(
                      width: 22.0,
                    ),
                    IconPickerBuilder(
                        iconData: taskIcon,
                        highlightColor: taskColor,
                        action: (newIcon) =>
                            setState(() => taskIcon = newIcon)),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                heroTag: 'fab_new_card',
                icon: Icon(Icons.save),
                backgroundColor: taskColor,
                label: Text('Create New Card'),
                onPressed: () async {
                  if (newTask.isEmpty) {
                    final snackBar = SnackBar(
                      content: Text(
                          'Card name is emapty.'),
                      backgroundColor: taskColor,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    // _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    model.addTask(Task(
                      newTask,
                      codePoint: taskIcon.codePoint,
                      color: taskColor.value
                    ));
                  //  cardProvider.addCard(CardData("id", "dateOfCard", newTask, description,  taskColor.value.toString(), taskIcon.codePoint.toString()));
                    addDataCard();
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
// Reason for wraping fab with builder (to get scafold context)
// https://stackoverflow.com/a/52123080/4934757
