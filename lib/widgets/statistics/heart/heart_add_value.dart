import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/dialogs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../providers/heart.dart';
import '../../../utils/dialog_utils.dart';
import '../../layout/scrollable_centered_form_wrapper.dart';

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
    Dialogs.showSnackBar(S.of(context).commonsSnackbarMsgSaved, context);
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
          decoration: InputDecoration(labelText: S.of(context).bloodPressureAddValueInputLabelSystolic),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return S.of(context).commonsValidatorMsgEmptyValue;
            var val = int.tryParse(value);
            if (val == null || val <= 0) return S.of(context).commonsValidatorMsgNumberGtZeroRequired;
            return null;
          },
          onSaved: (value) => _high = int.parse(value!),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: S.of(context).bloodPressureAddValueInputLabelDiastolic),
          textInputAction: TextInputAction.done,
          keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (value) {
            if (value == null || value.isEmpty) return S.of(context).commonsValidatorMsgEmptyValue;
            var val = int.tryParse(value);
            if (val == null || val <= 0) return S.of(context).commonsValidatorMsgNumberGtZeroRequired;
            return null;
          },
          onSaved: (value) => _low = int.parse(value!),
        ),
      ],
    );
  }
}
