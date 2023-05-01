import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/config/theme/custom_text_field.dart';
import 'package:jaijaoni/providers/create/create_debt_data_provider.dart';

import 'add_people.dart';

class DebtForm extends ConsumerStatefulWidget {
  const DebtForm({super.key});

  @override
  ConsumerState<DebtForm> createState() => _DebtFormState();
}

class _DebtFormState extends ConsumerState<DebtForm> {
  late final allInfo = ref.watch(createDebtDataProvider);
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: allInfo.name);
  late final _dueDate = TextEditingController(text: allInfo.dueDate);
  late final _price = TextEditingController(
      text:
          allInfo.totalPrice <= 0 ? "" : allInfo.totalPrice.toStringAsFixed(2));
  // String _dateText = "";

  void _selectDate() async {
    try {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _dueDate.text == ""
              ? DateTime.now()
              : DateTime.parse(_dueDate.text),
          firstDate: DateTime.now(),
          lastDate: DateTime(2025));
      if (picked != null) {
        _dueDate.text = "${picked.year}-${picked.month}-${picked.day}";
      } else {
        _dueDate.text = "";
      }
      setState(() {});
    } catch (err) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _name,
                          validator: (value) => value!.isEmpty
                              ? "Name should not be empty"
                              : null,
                          decoration: roundInput.copyWith(labelText: 'Name'),
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        TextFormField(
                          readOnly: true,
                          onTap: () {
                            _selectDate();
                          },
                          controller: _dueDate,
                          validator: (value) => value!.isEmpty
                              ? "Date should not be empty"
                              : null,
                          decoration: roundInput.copyWith(
                              labelText: 'Due date',
                              suffixIcon: _dueDate.text != ""
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                          onPressed: () {
                                            _dueDate.text = "";
                                            setState(() {});
                                          },
                                          icon: const Icon(Icons.close)),
                                    )
                                  : null),
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        TextFormField(
                            controller: _price,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !RegExp(r'^(\d*\.)?\d+$').hasMatch(value)) {
                                return 'Please type the correct amount';
                              }
                              if (double.parse(value) <= 0) {
                                return 'Total price should be more than 0';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}'))
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration:
                                roundInput.copyWith(labelText: 'Total price'))
                      ],
                    )),
                const SizedBox(height: 150),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.primary),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              allInfo.changeDeptInfo(
                                  name: _name.text,
                                  dueDate: _dueDate.text,
                                  totalPrice: double.parse(_price.text));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddPeople(
                                            price: _price.text,
                                          )));
                            }
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          )),
                    ),
                    // const SizedBox(
                    //   width: 13,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}