import 'dart:html';

import 'package:flutter/material.dart';
import 'package:checklist/repositories/task.dart';

import '../../models/task.dart';

class CreateTask extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _task = Task(1);
  final _repository = TaskRepository();

  onSave(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.create(_task);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar tarefa"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
                child: Column(children: [
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(labelText: "Item"),
                    onSaved: (value) => _task.name = value,
                    validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Quantidade"),
                    onSaved: (value) => _task.quantity = int.parse(value),
                    validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Preço"),
                    onSaved: (value) => _task.value = double.parse(value),
                    validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Anotação", isDense: true),
                    onSaved: (value) => _task.description = value,
                  ),
                ]
              ),
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
              onPressed: () => onSave(context),
            ),
          )
        ],
      ),
    );
  }
}
