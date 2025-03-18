import 'package:todo_block/model/model.dart';

abstract class todoEvent{}

class addTodo extends todoEvent{
  todoModel newModel;
  addTodo({required this.newModel});
}
class updateTodo extends todoEvent{
  int nId;
  String nTitle;
  String nDesc;
  updateTodo({required this.nId, required this.nTitle, required this.nDesc});
}
class updateIsComleted extends todoEvent{
  int id ;
  bool isCompleted;
  updateIsComleted({required this.id, required this.isCompleted});
}

class deleteTodo extends todoEvent{
  int id;
  deleteTodo ({required this.id});
}

class getInitialTodo extends todoEvent{}



