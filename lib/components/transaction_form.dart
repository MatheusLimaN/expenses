import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptative_button.dart';
import 'adaptative_datePicker.dart';
import 'adaptative_textField.dart';

class TransactionForm extends StatefulWidget {
  final void Function({String title, double value, DateTime date}) onSubmit;

  TransactionForm({Key key, this.onSubmit}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _onSubmit() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title: title, value: value, date: _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 20.0 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              Text(
                'Cadastrar nova despesa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              AdapdativeTextField(
                controller: _titleController,
                onSubmitted: (_) => _onSubmit(),
                label: 'Título',
              ),
              AdapdativeTextField(
                controller: _valueController,
                onSubmitted: (_) => _onSubmit(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                label: 'Valor (R\$)',
              ),
              AdaptativeDatePicker(
                onDateChanged: (value) => setState(() => _selectedDate = value),
                selectedDate: _selectedDate,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                      label: 'Nova transação', onPressed: _onSubmit)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
