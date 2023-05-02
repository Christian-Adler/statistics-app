import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/dialogs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/exception/api_exception.dart';
import '../../providers/heart.dart';
import '../layout/scrollable_centered_form_wrapper.dart';

class HeartAddValue extends StatefulWidget {
  const HeartAddValue({required Key key}) : super(key: key);

  @override
  State<HeartAddValue> createState() => HeartAddValueState();
}

class HeartAddValueState extends State<HeartAddValue> {
  final _form = GlobalKey<FormState>();
  var isLoading = false;
  int _high = 0;
  int _low = 0;

  void _showSuccessMessage() {
    Dialogs.showSnackBar('gespeichert...', context);
  }

  Future<void> saveForm() async {
    var currentState = _form.currentState;
    if (currentState == null || !currentState.validate()) return;
    currentState.save();

    setState(() {
      isLoading = true;
    });

    var power = Provider.of<Heart>(context, listen: false);
    try {
      await power.addBloodPressureEntry(_high, _low);
      _showSuccessMessage();
    } on ApiException catch (err) {
      await Dialogs.simpleOkDialog(err.message, context, title: 'Fehler');
    } catch (err) {
      await Dialogs.simpleOkDialog(err.toString(), context, title: 'Fehler');
    }

    setState(() {
      isLoading = false;
    });
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final insertDate = DateFormat('dd MMMM yyyy - HH:mm:ss').format(DateTime.now());

    return ScrollableCenteredFormWrapper(
      formKey: _form,
      children: [
        Text(
          insertDate,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextFormField(
          autofocus: true,
          decoration: const InputDecoration(labelText: 'systolisch (oberer)'),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter a value';
            var val = int.tryParse(value);
            if (val == null || val <= 0) return 'Please provide a valid number > 0';
            return null;
          },
          onSaved: (value) => _high = int.parse(value!),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'diastolisch (unterer)'),
          textInputAction: TextInputAction.done,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter a value';
            var val = int.tryParse(value);
            if (val == null || val <= 0) return 'Please provide a valid number > 0';
            return null;
          },
          onSaved: (value) => _low = int.parse(value!),
        ),
      ],
    );
  }
}
