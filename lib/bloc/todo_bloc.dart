import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_block/bloc/todo_event.dart';
import 'package:todo_block/bloc/todo_state.dart';
import 'package:todo_block/database/db_helper.dart';
import 'package:todo_block/model/model.dart';

class todoBloc extends Bloc<todoEvent, todoState>{
  dbHelper DbHelper;
  todoBloc({required this.DbHelper}) : super (todoState(mTodo: [])){

    on<addTodo>((event,emit)async{
      bool check = await DbHelper.addTodo(newModel: event.newModel);
      if(check){
        List<todoModel> allTodo = await DbHelper.fetchAllTodo();
        emit(todoState(mTodo: allTodo));
      }
    });

    on<updateTodo>((event,state)async{
      bool check = await DbHelper.updateTodo(nId: event.nId, nTitle: event.nTitle, nDesc: event.nDesc);
      if(check){
        List<todoModel> uTodo = await DbHelper.fetchAllTodo();
        emit(todoState(mTodo: uTodo));
      }
    });

    on<deleteTodo>((event,state)async{
      bool check = await DbHelper.deleteTodo(nId: event.id);

      if(check){
        List<todoModel> dTodo = await DbHelper.fetchAllTodo();
        emit(todoState(mTodo: dTodo));
      }
    });
    on<updateIsComleted>((event,state)async{
      bool check = await DbHelper.updateIsCompleted(nID: event.id, isComplete: event.isCompleted);
      if(check){
        List<todoModel> isTodo = await DbHelper.fetchAllTodo();
        emit(todoState(mTodo: isTodo));
      }
    });

    on<getInitialTodo>((event, state)async{
      List<todoModel> fetchTodo = await DbHelper.fetchAllTodo();
      emit(todoState(mTodo: fetchTodo));
    });

  }
}