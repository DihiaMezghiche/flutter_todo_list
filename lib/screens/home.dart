// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/widgets/todo_item.dart';

class Home  extends StatelessWidget {
  Home ({ Key? key }) : super(key: key);
  final todosList = ToDo.todoList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 50,
                          bottom: 50
                        ) ,
                        child: Text('All ToDos', style: TextStyle(color: tdBlack, fontSize: 30, fontWeight: FontWeight.w500)),
                      ),
                      for ( ToDo todo in todosList)
                        ToDoItem(todo: todo,),
                      
                    ],
                  ),
                )

              ],)
          ),
          
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpg'),) 
        )
      ]),
      );
  }

  Widget searchBox()
  {
    return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
              // ignore: prefer_const_constructors
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
                  prefixIconConstraints: BoxConstraints(maxHeight: 20,minWidth: 25),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: tdGrey)
                  )
                  ,
              ),
            );
  }
}