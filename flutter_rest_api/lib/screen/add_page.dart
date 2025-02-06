// ignore_for_file: avoid_print


import 'package:flutter/material.dart';
import 'package:flutter_rest_api/services/todo_service.dart';
import 'package:flutter_rest_api/utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      isEdit = true;
      titleController.text = widget.todo!['title'];
      descriptionController.text = widget.todo!['description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isEdit ? Text('Edit Todo') : Text('Add Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Title',
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: 'Description',
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 8,
            minLines: 5,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isEdit ? updateTodo : submitData,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                isEdit ? 'Update' : 'Submit',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateTodo() async {
    final todo = widget.todo;
    if (todo == null) {
      print('You can not call updated without todo data');
      return;
    }
    final id = todo['_id'];

    final isSuccess = await TodoService.updateTodo(id, body);
    if (isSuccess) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage(context, message:'Todo created successfully');
    } else {
      showErrorMessage(context, message:'Todo creation failed');
    }
  }

  void submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      'title': title,
      'description': description,
      'isCompleted': false,
    };
    final isSuccess = await TodoService.addTodo(body);
    if (isSuccess) {
      titleController.text = '';
      descriptionController.text = '';
      print('creation success');
      showSuccessMessage(context, message:'Todo created successfully');
    } else {
      showErrorMessage(context, message:'Todo creation failed');
    }
  }

  Map get body{
    final title = titleController.text;
    final description = descriptionController.text;
    return  {
      'title': title,
      'description': description,
      'isCompleted': false,
    };
  }
}
