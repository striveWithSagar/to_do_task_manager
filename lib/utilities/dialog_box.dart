import 'package:flutter/material.dart';
import 'package:to_do_task_manager/utilities/buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;

  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
              super.key,
              required this.controller,
              required this.onSave,
              required this.onCancel,
  });


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 200,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [


            //getting user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new Text',
              ),
            ),

            const SizedBox(height: 2,),

            //buttons - save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [

                //save button
                MyButtons(text: 'Save', onPressed:onSave),

                const SizedBox(width: 4,),


                //cancel button
                MyButtons(text: 'Cancel', onPressed: onCancel),




              ],
            ),



          ],


        ),

      ),

    );
  }
}
