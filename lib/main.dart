import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';

void main() {
  runApp(
    BlocProvider(
      create:(_)=>TodoBloc(),
      child: MaterialApp(home: TodoScreen()),
      ),
  );
}
class TodoScreen extends StatelessWidget{
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context){
    final controller =TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc To-Do")
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(16.0),
          child:Row(
            children: [
              Expanded(
                child:TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText:'Add a task'),
                ),
                ),
                IconButton(icon: Icon(Icons.add),
                onPressed: (){
                  if(controller.text.trim().isNotEmpty){
                    context.read<TodoBloc>().add(AddTodo(controller.text.trim()));
                    controller.clear();
                  }
                },
                ),
            ],
          ) ,
          ),
          Expanded(
            child: BlocBuilder<TodoBloc,TodoState>(
              builder:(context,State){
                if(State.todos.isEmpty){
                  return Center(child: Text('No task yet'));
                }
                return ListView.builder(
                  itemCount: State.todos.length,
                  itemBuilder: (context,index){
                    final todo =State.todos[index];
                    return ListTile(
                      leading: Checkbox(value: todo.isCompleted,
                       onChanged: (_)=>
                       context.read<TodoBloc>().add(ToggleTodo(todo.id)),
                       ),
                       title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isCompleted
                          ?TextDecoration.lineThrough
                          :null,
                        ),
                       ),
                       trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: ()=>
                        context.read<TodoBloc>().add(DeleteTodo(todo.id)),
                    ),
                    );
                  },
                );
              } ,
              ),
          )
        ],
      ),
    );
  }
}
