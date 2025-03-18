import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_block/bloc/todo_bloc.dart';
import 'package:todo_block/bloc/todo_event.dart';
import 'package:todo_block/widget/detail_page.dart';

import '../bloc/todo_state.dart';
import '../model/model.dart';


class homePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => homePageState();
}
class homePageState extends State<homePage>{

  @override
  void initState() {
    super.initState();

   context.read<todoBloc>().add(getInitialTodo());

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Todo",style: TextStyle(fontSize: 30,fontFamily: "PoppinsBold",color: Colors.white)),
          backgroundColor: Colors.black,
          bottom: TabBar(
            indicatorColor: Color(0xffFF7433),
            labelStyle: TextStyle(fontSize: 16,fontFamily: "Poppins",fontWeight: FontWeight.bold,color: Color(0xffFF7433)),
              unselectedLabelColor: Colors.white,
              //unselectedLabelStyle: TextStyle(color: Colors.white),
              labelColor: Color(0xffFF7433),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2,
              tabs: [
            Tab(
              text: "All",

            ),
            Tab(
              text: "Pending",
            ),
            Tab(
              text: "Completed",
            ),
          ]),
        ),
        body: TabBarView(children: [
          BlocBuilder<todoBloc,todoState>(builder: (_,state){
            return state.mTodo.isEmpty? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("asset/image/no_task.png",height: 160,),
                SizedBox(height: 11,),
                Text("No Todo's Yet!!!",style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
              ],
            )  :ListView.builder(
                itemCount: state.mTodo.length,
                itemBuilder: (_,index){
                  return GestureDetector(
                    onLongPress: (){
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (_) {
                            return Container(
                              width: 330,
                              height: 180,
                              margin: EdgeInsets.only(bottom: 25),
                              decoration: BoxDecoration(
                                  color:Color(0xff242424),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Delete this Item ?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style:ElevatedButton.styleFrom(
                                              minimumSize: Size(140, 50),
                                              backgroundColor: Color(0xff363636),
                                              foregroundColor: Colors.white
                                          ),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(fontSize: 15),
                                          )),
                                      ElevatedButton(
                                          onPressed: () {
                                            context.read<todoBloc>().add(deleteTodo(id: state.mTodo[index].nId!));
                                            Navigator.pop(context);
                                          },
                                          style:ElevatedButton.styleFrom(
                                              minimumSize: Size(140, 50),
                                              backgroundColor: Color(0xff363636),
                                              foregroundColor: Colors.red
                                          )
                                          ,
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.red),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color(0xff242424),
                          borderRadius: BorderRadius.circular(12),
                         ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>detailPage(id: state.mTodo[index].nId!, nTitle: state.mTodo[index].nTitle, nDesc: state.mTodo[index].nDesc)));
                        },
                        leading: Checkbox(
                          side: BorderSide(color: Colors.white,width: 2),
                            activeColor: Color(0xffFF7433),
                            value: state.mTodo[index].isCompleted, onChanged: (value){
                          context.read<todoBloc>().add(updateIsComleted(id: state.mTodo[index].nId!, isCompleted: value??false));
                        }),
                        enabled: !state.mTodo[index].isCompleted,
                        title: Text(state.mTodo[index].nTitle,overflow: TextOverflow.ellipsis,maxLines:1,style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: "Poppins",fontWeight: FontWeight.bold,decoration: state.mTodo[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,decorationColor: Colors.white,decorationThickness: 3),),
                        subtitle: Text(state.mTodo[index].nDesc,overflow: TextOverflow.ellipsis,maxLines:1,style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: "Poppins",decoration: state.mTodo[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,decorationColor: Colors.white,decorationThickness: 3),),
                      ),
                    ),
                  );
                });
          }),
          BlocBuilder<todoBloc,todoState>(builder: (_,state){
            return state.mTodo.isEmpty? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("asset/image/no_task.png",height: 160,),
                SizedBox(height: 11,),
                Text("No Pending Todo's Yet!!!",style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
              ],
            )  :ListView.builder(
                itemCount: state.mTodo.length,
                itemBuilder: (_,index){
                  return state.mTodo[index].isCompleted ? Container() :GestureDetector(
                    onLongPress: (){
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (_) {
                            return Container(
                              width: 330,
                              height: 180,
                              margin: EdgeInsets.only(bottom: 25),
                              decoration: BoxDecoration(
                                  color:Color(0xff242424),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Delete this Item ?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style:ElevatedButton.styleFrom(
                                              minimumSize: Size(140, 50),
                                              backgroundColor: Color(0xff363636),
                                              foregroundColor: Colors.white
                                          ),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(fontSize: 15),
                                          )),
                                      ElevatedButton(
                                          onPressed: () {
                                            context.read<todoBloc>().add(deleteTodo(id: state.mTodo[index].nId!));
                                            Navigator.pop(context);
                                          },
                                          style:ElevatedButton.styleFrom(
                                              minimumSize: Size(140, 50),
                                              backgroundColor: Color(0xff363636),
                                              foregroundColor: Colors.red
                                          )
                                          ,
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.red),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xff242424),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>detailPage(id: state.mTodo[index].nId!, nTitle: state.mTodo[index].nTitle, nDesc: state.mTodo[index].nDesc)));
                        },
                        leading: Checkbox(
                            side: BorderSide(color: Colors.white,width: 2),
                            activeColor: Color(0xffFF7433),
                            value: state.mTodo[index].isCompleted, onChanged: (value){
                          context.read<todoBloc>().add(updateIsComleted(id: state.mTodo[index].nId!, isCompleted: value??false));
                        }),
                        enabled: !state.mTodo[index].isCompleted,
                        title: Text(state.mTodo[index].nTitle,overflow: TextOverflow.ellipsis,maxLines:1,style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: "Poppins",fontWeight: FontWeight.bold,decoration: state.mTodo[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,decorationColor: Colors.white,decorationThickness: 3),),
                        subtitle: Text(state.mTodo[index].nDesc,overflow: TextOverflow.ellipsis,maxLines:1,style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: "Poppins",decoration: state.mTodo[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,decorationColor: Colors.white,decorationThickness: 3),),
                      ),
                    ),
                  );
                });
          }),
          BlocBuilder<todoBloc,todoState>(builder: (_,state){
            return state.mTodo.isEmpty? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("asset/image/no_task.png",height: 160,),
                SizedBox(height: 11,),
                Text("No Completed Todo's Yet!!!",style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: "Poppins",fontWeight: FontWeight.bold),),
              ],
            )  :ListView.builder(
                itemCount: state.mTodo.length,
                itemBuilder: (_,index){
                  return state.mTodo[index].isCompleted ? GestureDetector(
                    onLongPress: (){
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (_) {
                            return Container(
                              width: 330,
                              height: 180,
                              margin: EdgeInsets.only(bottom: 25),
                              decoration: BoxDecoration(
                                  color:Color(0xff242424),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Delete this Item ?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style:ElevatedButton.styleFrom(
                                              minimumSize: Size(140, 50),
                                              backgroundColor: Color(0xff363636),
                                              foregroundColor: Colors.white
                                          ),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(fontSize: 15),
                                          )),
                                      ElevatedButton(
                                          onPressed: () {
                                            context.read<todoBloc>().add(deleteTodo(id: state.mTodo[index].nId!));
                                            Navigator.pop(context);
                                          },
                                          style:ElevatedButton.styleFrom(
                                              minimumSize: Size(140, 50),
                                              backgroundColor: Color(0xff363636),
                                              foregroundColor: Colors.red
                                          )
                                          ,
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.red),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xff242424),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>detailPage(id: state.mTodo[index].nId!, nTitle: state.mTodo[index].nTitle, nDesc: state.mTodo[index].nDesc)));
                        },
                        leading: Checkbox(
                            side: BorderSide(color: Colors.white,width: 2),
                            activeColor: Color(0xffFF7433),
                            value: state.mTodo[index].isCompleted, onChanged: (value){
                          context.read<todoBloc>().add(updateIsComleted(id: state.mTodo[index].nId!, isCompleted: value??false));
                        }),
                        enabled: !state.mTodo[index].isCompleted,
                        title: Text(state.mTodo[index].nTitle,overflow: TextOverflow.ellipsis,maxLines:1,style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: "Poppins",fontWeight: FontWeight.bold,decoration: state.mTodo[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,decorationColor: Colors.white,decorationThickness: 3),),
                        subtitle: Text(state.mTodo[index].nDesc,overflow: TextOverflow.ellipsis,maxLines:1,style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: "Poppins",decoration: state.mTodo[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,decorationColor: Colors.white,decorationThickness: 3),),
                      ),
                    ),
                  ) : Container();
                });
          }),
        ]),
        floatingActionButton: FloatingActionButton(onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> detailPage(id: -1, nTitle: "", nDesc: "")));
        },
          backgroundColor: Color(0xffFF7433),
          foregroundColor: Colors.white,

          child: Icon(Icons.add,size: 30,),
        ),
      ),
    );
  }
}
