// todo_event.dart
abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String todoItem;
  AddTodoEvent({required this.todoItem});
}

class RemoveTodoEvent extends TodoEvent {
  final int index;
  RemoveTodoEvent({required this.index});
}
