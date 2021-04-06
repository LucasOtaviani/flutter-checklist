import '../models/task.dart';

class TaskRepository
{
  static List<Task> tasks = [];

  TaskRepository()
  {
    if (tasks.isEmpty) {
      tasks.add(Task(1, name: "Pão", quantity: 8, value: 0.25));
      tasks.add(Task(2, name: "Manteiga", quantity: 1, value: 4.75, finished: false));
      tasks.add(Task(3, name: "Sabonete", quantity: 3, value: 2.25, finished: false));
      tasks.add(Task(4, name: "Shampoo", quantity: 2, value: 4.50, finished: false));
      tasks.add(Task(5, name: "Alface", quantity: 1, value: 3.00, finished: false));
      tasks.add(Task(6, name: "Chocolate", quantity: 2, value: 5.50, finished: false));
    }
  }

  void create(Task task)
  {
    var lastTaskId = read().last.id;
    task.id = lastTaskId + 1;

    tasks.add(task);
  }

  List<Task> read()
  {
    tasks.sort((current, next) => current.id.compareTo(next.id));

    return tasks;
  }

  void delete(int id) {
    final task = tasks.singleWhere((task) => task.id == id);
    tasks.remove(task);
  }

  void update(Task newTask, Task oldTask) {
    final task = tasks.singleWhere((task) => task.id == oldTask.id);

    task.name = newTask.name;
    task.quantity = newTask.quantity;
    task.value = newTask.value;
  }
}
