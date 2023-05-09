import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/dialogs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/exception/api_exception.dart';
import '../../../providers/operating.dart';
import '../../../utils/date_utils.dart';
import '../../layout/scrollable_centered_form_wrapper.dart';

class OperatingAddValue extends StatefulWidget {
  const OperatingAddValue({Key? key}) : super(key: key);

  @override
  State<OperatingAddValue> createState() => OperatingAddValueState();
}

class OperatingAddValueState extends State<OperatingAddValue> {
  final _form = GlobalKey<FormState>();
  var isLoading = false;
  double _water = 0.0;
  double _consumedPower = 0.0;
  double _feedPower = 0.0;
  double _heatingHT = 0.0;
  double _heatingNT = 0.0;

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

    var power = Provider.of<Operating>(context, listen: false);
    try {
      await power.addOperatingEntry(_water, _consumedPower, _feedPower, _heatingHT, _heatingNT);
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

    final insertDate = DateFormat('MMMM yyyy').format(DateUtil.getInsertDate());

    return ScrollableCenteredFormWrapper(
      formKey: _form,
      children: [
        Text(
          insertDate,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextFormField(
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Wasser (m³ = alle großen Zahlen)'),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter a value';
            var val = double.tryParse(value);
            if (val == null || val <= 0) return 'Please provide a valid number > 0';
            return null;
          },
          onSaved: (value) => _water = double.parse(value!),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Strom (kWh)'),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter a value';
            var val = double.tryParse(value);
            if (val == null || val <= 0) return 'Please provide a valid number > 0';
            return null;
          },
          onSaved: (value) => _consumedPower = double.parse(value!),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Strom Eingespeist (kWh)'),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter a value';
            var val = double.tryParse(value);
            if (val == null || val <= 0) return 'Please provide a valid number > 0';
            return null;
          },
          onSaved: (value) => _feedPower = double.parse(value!),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Strom Wärmepumpe HT (kWh)'),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter a value';
            var val = double.tryParse(value);
            if (val == null || val <= 0) return 'Please provide a valid number > 0';
            return null;
          },
          onSaved: (value) => _heatingHT = double.parse(value!),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Strom Wärmepumpe NT (kWh)'),
          textInputAction: TextInputAction.send,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter a value';
            var val = double.tryParse(value);
            if (val == null || val <= 0) return 'Please provide a valid number > 0';
            return null;
          },
          onSaved: (value) => _heatingNT = double.parse(value!),
          onEditingComplete: () => saveForm(),
        ),
      ],
    );
  }
}
