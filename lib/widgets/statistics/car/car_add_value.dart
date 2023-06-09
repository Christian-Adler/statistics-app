import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/dialogs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/exception/api_exception.dart';
import '../../../providers/car.dart';
import '../../../utils/dialog_utils.dart';
import '../../layout/scrollable_centered_form_wrapper.dart';

class CarAddValue extends StatefulWidget {
  const CarAddValue({Key? key}) : super(key: key);

  @override
  State<CarAddValue> createState() => CarAddValueState();
}

class CarAddValueState extends State<CarAddValue> {
  final _form = GlobalKey<FormState>();
  var isLoading = false;
  double _liter = 0.0;
  double _centPerLiter = 0.0;
  double _km = 0.0;

  void _showSuccessMessage() {
    Dialogs.showSnackBar(S.of(context).commonsSnackbarMsgSaved, context);
  }

  Future<void> saveForm() async {
    var currentState = _form.currentState;
    if (currentState == null || !currentState.validate()) return;
    currentState.save();

    setState(() {
      isLoading = true;
    });

    var power = Provider.of<Car>(context, listen: false);
    try {
      await power.addCarRefuelEntry(_liter, _centPerLiter, _km);
      _showSuccessMessage();
    } on ApiException catch (err) {
      await DialogUtils.showSimpleOkErrDialog(err.message, context);
    } catch (err) {
      await DialogUtils.showSimpleOkErrDialog(err.toString(), context);
    }

    setState(() {
      isLoading = false;
    });
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LinearProgressIndicator();
    }

    final insertDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    return ScrollableCenteredFormWrapper(
      formKey: _form,
      children: [
        Text(
          insertDate,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextFormField(
          autofocus: true,
          decoration: InputDecoration(labelText: S.of(context).carAddValueInputLabelLiters),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return S.of(context).commonsValidatorMsgEmptyValue;
            var val = double.tryParse(value);
            if (val == null || val <= 0) return S.of(context).commonsValidatorMsgNumberGtZeroRequired;
            return null;
          },
          onSaved: (value) => _liter = double.parse(value!),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: S.of(context).carAddValueInputLabelCentPerLiter),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return S.of(context).commonsValidatorMsgEmptyValue;
            var val = double.tryParse(value);
            if (val == null || val <= 0) return S.of(context).commonsValidatorMsgNumberGtZeroRequired;
            return null;
          },
          onSaved: (value) => _centPerLiter = double.parse(value!),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: S.of(context).carAddValueInputLabelKilometers),
          textInputAction: TextInputAction.done,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return S.of(context).commonsValidatorMsgEmptyValue;
            var val = double.tryParse(value);
            if (val == null || val <= 0) return S.of(context).commonsValidatorMsgNumberGtZeroRequired;
            return null;
          },
          onSaved: (value) => _km = double.parse(value!),
        ),
      ],
    );
  }
}
