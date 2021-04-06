import 'dart:html';

import 'package:flutter/material.dart';
import 'package:checklist/repositories/task.dart';

import '../../models/task.dart';

class UpateTask extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _task = Task(1);
  final _repository = TaskRepository();

  onSave(BuildContext context, Task task) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); // submit do form do HTML
      _repository.update(_task, task);

      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Task task = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar tarefa"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child:Column(children: [
                TextFormField(
                  initialValue: task.name,
                  decoration: InputDecoration(
                    labelText: "Nome do produto",
                  ),
                  onSaved: (value) => _task.name = value,
                  validator: (value) => value.isEmpty ? "Item" : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  initialValue: task.quantity.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Quantidade"),
                  onSaved: (value) => _task.quantity = int.parse(value),
                  validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
                ),
                SizedBox(height: 8),
                TextFormField(
                  initialValue: task.value.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Preço"),
                  onSaved: (value) => _task.value = double.parse(value),
                  validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
                ),
              ]),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            width: double.infinity,
            child: RaisedButton(
              child: Text(
                "Salvar",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => onSave(context, task),
            ),
          )
        ],
      ),
    );
  }
}

// FlatButton(
//             child: Text(
//               "Salvar",
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             onPressed: () => onSave(context, task),
//           )
