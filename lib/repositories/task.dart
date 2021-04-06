import '../models/task.dart';

class TaskRepository
{
  static List<Task> tasks = [];

  TaskRepository()
  {
    if (tasks.isEmpty) {
      tasks.add(Task(1, name: "Maçã", quantity: 15, value: 10, description: "Pegue apenas as maçãs grandes! As pequenas não da nem pra 2 mordidas."));
      tasks.add(Task(2, name: "Pêra", quantity: 16, value: 90, finished: false));
      tasks.add(Task(3, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(4, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(5, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(6, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(7, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(8, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(9, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(10, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(11, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(12, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(13, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(14, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(15, name: "Pepino", quantity: 10, value: 100, finished: false));
      tasks.add(Task(16, name: "Pepino", quantity: 10, value: 100, finished: false));
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
    task.description = newTask.description;
  }
}
