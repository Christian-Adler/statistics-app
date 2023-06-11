import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/dialogs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../providers/operating.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/dialog_utils.dart';
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
    Dialogs.showSnackBar(S.of(context).commonsSnackbarMsgSaved, context);
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
    } catch (err) {
      await DialogUtils.showSimpleOkErrDialog(err, context);
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
          decoration: InputDecoration(labelText: S.of(context).operatingAddValueInputLabelWater),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return S.of(context).commonsValidatorMsgEmptyValue;
            var val = double.tryParse(value);
            if (val == null || val <= 0) return S.of(context).commonsValidatorMsgNumberGtZeroRequired;
            return null;
          },
          onSaved: (value) => _water = double.parse(value!),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: S.of(context).operatingAddValueInputLabelPower),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return S.of(context).commonsValidatorMsgEmptyValue;
            var val = double.tryParse(value);
            if (val == null || val <= 0) return S.of(context).commonsValidatorMsgNumberGtZeroRequired;
            return null;
          },
          onSaved: (value) => _consumedPower = double.parse(value!),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: S.of(context).operatingAddValueInputLabelPowerFed),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return S.of(context).commonsValidatorMsgEmptyValue;
            var val = double.tryParse(value);
            if (val == null || val <= 0) return S.of(context).commonsValidatorMsgNumberGtZeroRequired;
            return null;
          },
          onSaved: (value) => _feedPower = double.parse(value!),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: S.of(context).operatingAddValueInputLabelPowerHeatingDay),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return S.of(context).commonsValidatorMsgEmptyValue;
            var val = double.tryParse(value);
            if (val == null || val <= 0) return S.of(context).commonsValidatorMsgNumberGtZeroRequired;
            return null;
          },
          onSaved: (value) => _heatingHT = double.parse(value!),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: S.of(context).operatingAddValueInputLabelPowerHeatingNight),
          textInputAction: TextInputAction.send,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return S.of(context).commonsValidatorMsgEmptyValue;
            var val = double.tryParse(value);
            if (val == null || val <= 0) return S.of(context).commonsValidatorMsgNumberGtZeroRequired;
            return null;
          },
          onSaved: (value) => _heatingNT = double.parse(value!),
          onEditingComplete: () => saveForm(),
        ),
      ],
    );
  }
}
