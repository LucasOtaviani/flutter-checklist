import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:checklist/repositories/task.dart';
import '../../models/task.dart';

class IndexTasks extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexTasks> {
  final repository = TaskRepository();

  List<Task> tasks = [];
  List<Task> disabledTasks = [];

  bool canEdit = false;

  initState() {
    super.initState();
    this.tasks = repository.read();
  }

  Future<void> createTask(BuildContext context) async 
  {
    var response = await Navigator.of(context).pushNamed('/create');
  
    setState(() {
      if (response != null && response == true) {
        this.tasks = repository.read();
        sort();
      }
    });
  }

  Future<bool> confirmDeletion(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("Confirma a exclusão?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Não"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> confirmDisable(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("Deseja desabilitar este item?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Não"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> enableTask(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("Deseja habilitar este item?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Não"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateTasks(BuildContext context, Task task) async {
    {
      var result = await Navigator.of(context).pushNamed(
        '/update',
        arguments: task,
      );
      setState(() {
        if (result != null && result == true) {
          this.tasks = repository.read();
          sort();
        }
      });
    }
  }

  double total() {
    return tasks.fold(0, (total, task) => total + (task.value * task.quantity));
  }

  void sort() {
    tasks.sort((a, b) => a.finished ? 1 : -1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checklist"),
        actions: [
          IconButton(
            onPressed: () => setState(() => canEdit = !canEdit),
            icon: Icon(Icons.edit)
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Itens",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  "(" + tasks.length.toString() + ")",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ]
            ),
            SizedBox(height: 8),
            Flexible(
              flex: 2,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (_, index) {
                  var task = tasks[index];

                  return Card(
                    color: task.active ? Colors.white : Colors.red,
                    child: Dismissible(
                      key: Key(tasks[index].id.toString()),
                      background: Container(
                        color: Color(0xffff4b69),
                        child: Center(
                          child: Text("Remover",
                            style: TextStyle(
                              color: Colors.white
                            ),
                          )
                        )
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          repository.delete(task.id);
                          sort();
                          setState(() => this.tasks.remove(task));
                        } else if (direction == DismissDirection.endToStart) {
                          repository.delete(task.id);
                          sort();
                          setState(() {
                            disabledTasks.add(task);
                            tasks.remove(task);
                          });
                        }
                      },
                      confirmDismiss: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          return confirmDeletion(context);
                        } else if (direction == DismissDirection.endToStart) {
                          return confirmDisable(context);
                        }
                    
                        return null;
                      },
                      child: CheckboxListTile(
                        title: Row(
                          children: [
                            canEdit 
                              ? Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Colors.orange,
                                      onPressed: () =>
                                          updateTasks(context, task),
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                )
                              : Row(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  tasks[index].name,
                                  style: TextStyle(
                                    decoration: tasks[index].finished
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "(" + tasks[index].quantity.toString() + " itens)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    decoration: tasks[index].finished
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        value: tasks[index].finished,
                        onChanged: (value) {
                          return tasks[index].active
                            ? setState(() {
                                tasks[index].finished = value;
                                sort();
                              })
                            : Container();
                        },
                      ),
                    ),
                  );
                },
              ), // criar a lista com os dados do read();
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Itens Desabilitados",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  "(" + disabledTasks.length.toString() + ")",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ]
            ),
            SizedBox(height: 8),
            Flexible(
              child: ListView.builder(
                itemCount: disabledTasks.length,
                itemBuilder: (_, index) {
                  var disabledTask = disabledTasks[index];

                  return Card(
                    color: Color(0xFFEEEEEE),
                    child: ListTile(
                      title: Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                disabledTasks[index].name,
                                style: TextStyle(
                                  decoration: disabledTasks[index].finished
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                "(" + disabledTasks[index].quantity.toString() + " itens)",
                                style: TextStyle(
                                  fontSize: 12,
                                  decoration: disabledTasks[index].finished
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          tasks.add(disabledTask);     

                          disabledTask.finished = false;               
                          disabledTasks.remove(disabledTask);  

                          sort();               
                        });
                      },
                    ),
                  );
                },
              ), // criar a lista com os dados do read();
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => createTask(context),
      ),
    );
  }
}
