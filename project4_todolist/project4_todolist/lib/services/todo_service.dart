import '../models/todo.dart';
import '../repositories/repository.dart';

class TodoService {
  Repository? _repository;

  TodoService() {
    _repository = Repository();
  }

  //Create data
  saveTodo(Todo todo) async {
    return await _repository!.insertData('todos', todo.toMap());
  }

  //Read data
  readTodos() async {
    return await _repository!.readData('todos');
  }

  readTodoById(todoId) async {
    return await _repository!.readDataById('todos', todoId);
  }

  updateTodo(Todo todo) async {
    return await _repository!.updateData('todos', todo.toMap());
  }

  deleteTodo(todoId) async {
    return await _repository!.deleteData('todos', todoId);
  }

  readTodosByCateg(categ) async {
    return await _repository!.readDataByColumnName('todos', 'category', categ);
  }
}
