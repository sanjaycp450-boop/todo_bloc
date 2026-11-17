
import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent,TodoState>{
  TodoBloc():super( const TodoState()){

    on<AddTodo>(_onAddTodo);
    on<ToggleTodo>(_onToggleTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState>emit){
    final newTodo =Todo(
      id:DateTime.now().millisecondsSinceEpoch.toString(),
      title:event.title,     
    );
    emit(TodoState(todos:[...state.todos,newTodo]));

  }
  void _onToggleTodo(ToggleTodo event,Emitter<TodoState>emit){
   final updatedTodos =state.todos.map((todo){
    return todo.id ==event.id
    ?todo.copyWith(isCompleted:!todo.isCompleted)
    :todo;
   }).toList();
   emit(TodoState(todos:updatedTodos)); 
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState>emit){
    final updatedTodos=
    state.todos.where((todo)=>todo.id !=event.id).toList();
    emit(TodoState(todos:updatedTodos));
  }
}