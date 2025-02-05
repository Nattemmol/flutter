// todo_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState(todoList: [])) {
    on<AddTodoEvent>((event, emit) {
      final updatedList = List<String>.from(state.todoList)..add(event.todoItem);
      emit(TodoState(todoList: updatedList));
    });

    on<RemoveTodoEvent>((event, emit) {
      final updatedList = List<String>.from(state.todoList)..removeAt(event.index);
      emit(TodoState(todoList: updatedList));
    });
  }
}
