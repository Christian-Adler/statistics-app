import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/dialogs.dart';
import 'package:flutter_commons/widgets/layout/scrollable_centered_form_wrapper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../providers/operating.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/dialog_utils.dart';

class SolarPowerAddValue extends StatefulWidget {
  const SolarPowerAddValue({Key? key}) : super(key: key);

  @override
  State<SolarPowerAddValue> createState() => SolarPowerAddValueState();
}

class SolarPowerAddValueState extends State<SolarPowerAddValue> {
  final _form = GlobalKey<FormState>();
  var isLoading = false;
  var _value = 0.0;

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
      await power.addSolarPowerEntry(_value);
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
          decoration: InputDecoration(labelText: S.of(context).solarPowerAddValueInputLabelPowerGenerated),
          textInputAction: TextInputAction.done,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return S.of(context).commonsValidatorMsgEmptyValue;
            var val = double.tryParse(value);
            if (val == null || val <= 0) return S.of(context).commonsValidatorMsgNumberGtZeroRequired;
            return null;
          },
          onSaved: (value) => _value = double.parse(value!),
        ),
      ],
    );
  }
}
