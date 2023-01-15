// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  const ToDoItem({ Key? key, required this.todo }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        onTap: () {
          print('clicked on todo item');
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: Icon(todo.isDone? Icons.check_box : Icons.check_box_outline_blank ,color: tdBlue),
        title: Text(todo.todoText!, 
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: todo.isDone? TextDecoration.lineThrough: null)
            ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: 
          BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: (){
              print('clicked on delete button');
            },
          ),
        ),
      )
    );
  }
}