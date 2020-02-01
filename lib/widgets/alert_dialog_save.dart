import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class AlertDialogSave extends StatefulWidget {
  final Function disposeHolder;

  AlertDialogSave({this.disposeHolder});

  @override
  _AlertDialogSaveState createState() => _AlertDialogSaveState();
}

class _AlertDialogSaveState extends State<AlertDialogSave> {
  bool isEmpty = false;
  final _controllerDialog = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Guardando"),
      content: TextField(
        decoration: InputDecoration(
          labelText: "Titulo",
          errorText: isEmpty ? "Requerido" : null,
        ),
        controller: _controllerDialog,
      ),
      elevation: 8,
      actions: <Widget>[
        FlatButton(
          child: Text("Cancelar"),
          color: Colors.red[300],
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Guardar"),
          color: Theme.of(context).accentColor,
          onPressed: () {
            if (_controllerDialog.text.isNotEmpty) {
              widget.disposeHolder();
              Navigator.of(context).pop();
            } else {
              setState(() {
                isEmpty = true;
              });
            }
          },
        )
      ],
    );
  }
}
