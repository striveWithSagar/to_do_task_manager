import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/database.dart';
import '../utilities/dialog_box.dart';
import '../utilities/todo_tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //reference the hive box
  final _myBox = Hive.box('myBox');

  //list of to do tasks
  // List toDoList = [
  //   ["Make tutorial", false],
  //   ["Exervice", true],
  // ];

  //new version
  ToDoDataBase db = ToDoDataBase();

  void initState(){
    //if this is the 1st time ever openin the app, then creating the default data
    if(_myBox.get('TODOLIST') == null){
      db.createInitialData();
    }
    else{
      db.loadData();
    }

    super.initState();
  }

  //text Controller
  final _controller = TextEditingController();

  //clicked check box
  void checkBoxChanged (bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];

    });
    db.updateDataBase();
  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();

  }

  //creating new Task
  void createNewTask(){
    showDialog(
        context: context,
        builder: (context){
          return DialogBox(
              controller : _controller,
              onSave: saveNewTask,
              onCancel: ()=> Navigator.of(context).pop(),
          );
        }
    );
  }

  //delete a task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.yellow[200],

      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('To Do'),
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return TodoTasks(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
          );
        },


      ),
    );
  }
}
