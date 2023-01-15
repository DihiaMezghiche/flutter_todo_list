// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/widgets/todo_item.dart';

class Home  extends StatefulWidget {
  Home ({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    // TODO: implement initState
    _foundToDo = todosList;
    super.initState();
  }
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
                      for ( ToDo todo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _handleDeleteItem,),
                      
                    ],
                  ),
                )

              ],)
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [ BoxShadow(
                        color: Colors.grey, 
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0
                        ),],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add new todo item',
                        border: InputBorder.none,

                      ),
                    ),

                  )
                  ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),

                  child: ElevatedButton(
                    onPressed: (){
                      _addToDoItem(_todoController.text);
                    },
                    child:Text('+',
                      style: TextStyle(fontSize: 40),),
                    style: ElevatedButton.styleFrom(
                        primary: tdBlue,
                        minimumSize: Size(60,60),
                        elevation: 10
                      
                      ),
                    
                     ) ,
                )
                
              ]),
          )
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

  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeleteItem(String id){
    setState(() {
      todosList.removeWhere((element) => element.id == id);
    });
  }

  void _addToDoItem(String toDo){
    setState(() {
      todosList.add(
      ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyWord){
    List<ToDo> results = [];
    if(enteredKeyWord.isEmpty){
      results = todosList;
    }
    else{
      results = todosList.where((element) => element.todoText!.toLowerCase().contains(enteredKeyWord.toLowerCase())).toList();
    }

    setState(() {
      _foundToDo = results;
    });
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
                onChanged:(value) => _runFilter(value),
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