import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_block/bloc/todo_bloc.dart';
import 'package:todo_block/bloc/todo_event.dart';
import 'package:todo_block/model/model.dart';

class detailPage extends StatelessWidget{


  String nTitle;
  String nDesc;
  int id;

  detailPage({required this.id, required this.nTitle, required this.nDesc});

  TextEditingController nTitleController = TextEditingController();
  TextEditingController nDescController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    print("rebuild");
    nTitleController.text = nTitle;
    nDescController.text = nDesc;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        actions: [
          TextButton(onPressed: (){
            if (nTitleController.text.isNotEmpty ||
                nDescController.text.isNotEmpty) {
              if (id == -1) {

                context.read<todoBloc>().add(addTodo(newModel: todoModel(nTitle: nTitleController.text, nDesc: nDescController.text, isCompleted: false)));

                Navigator.pop(context);
              } else {
                context.read<todoBloc>().add(updateTodo(nId:id, nTitle: nTitleController.text, nDesc: nDescController.text));
                Navigator.pop(context);
              }
            }
          },
              child: Text("Save",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: "Poppins",fontSize: 15),)),
          SizedBox(width: 5,)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nTitleController,
                style: TextStyle(color: Colors.white,fontSize: 21),
                cursorColor: Colors.white,
                decoration: InputDecoration.collapsed(
                    hintText: "Title",
                    hintStyle: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.bold,fontSize:21,color: Color(0xff4C4C4C))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                maxLines:30,
                controller: nDescController,
                style: TextStyle(color: Colors.white,fontSize: 17),
                cursorColor: Colors.white,
                decoration: InputDecoration.collapsed(
                    hintText: "Description",
                    hintStyle: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.bold,fontSize:17,color: Color(0xff4C4C4C))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}