import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{
  List toDoList = [];

  //reference out box
  final _myBox =Hive.box('myBox');

  //first time opening the app ever
  void createInitialData(){
    toDoList = [
    ['Make Tutorial', false],
    ['do Exercise', false],
    ];
  }

  void loadData(){
    toDoList = _myBox.get('TODOLIST');
  }

  //update the Database
  void updateDataBase(){
    _myBox.put('TODOLIST', toDoList);
  }

}