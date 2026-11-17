

import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable{
  TodoEvent();

  @override
  List<Object> get props =>[];
 }
 class AddTodo extends TodoEvent{
  final String title;
  AddTodo(this.title);
  
  @override
  List<Object> get props =>[title];
 }

 class ToggleTodo extends TodoEvent{
  final String id;
  ToggleTodo(this.id);

  @override
  List<Object> get props =>[id];
 }
 class DeleteTodo extends TodoEvent{
  final String id;
  DeleteTodo(this.id);

  @override
  List<Object> get props =>[id];    
  }
