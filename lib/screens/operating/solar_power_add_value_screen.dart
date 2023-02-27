import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:statistics/utils/date_utils.dart';

import '../../providers/operating.dart';
import '../../utils/dialogs.dart';
import '../../widgets/statistics_app_bar.dart';

class SolarPowerAddValueScreen extends StatefulWidget {
  static const String routeName = '/solar_power_add_value';

  const SolarPowerAddValueScreen({Key? key}) : super(key: key);

  @override
  State<SolarPowerAddValueScreen> createState() => _SolarPowerAddValueScreenState();
}

class _SolarPowerAddValueScreenState extends State<SolarPowerAddValueScreen> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  var _value = 0.0;

  void _showSuccessMessage() {
    Dialogs.showSnackBar('gespeichert...', context);
  }

  Future<void> _saveForm() async {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    var power = Provider.of<Operating>(context, listen: false);
    try {
      await power.addSolarPowerEntry(_value);
      _showSuccessMessage();
    } catch (err) {
      await Dialogs.simpleOkDialog(err.toString(), context, title: 'Fehler');
    }

    setState(() {
      _isLoading = false;
    });
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final insertDate = DateFormat('MMMM yyyy').format(DateUtil.getInsertDate());

    return Scaffold(
      appBar: StatisticsAppBar(
        const Text('Solar Strom eintragen'),
        context,
        actions: [IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        insertDate,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration(labelText: 'Erzeugte Solar Energie (kWh)'),
                        textInputAction: TextInputAction.done,
                        keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter a kWh value';
                          var val = double.tryParse(value);
                          if (val == null || val <= 0) return 'Please provide a valid number > 0';
                          return null;
                        },
                        onSaved: (value) => _value = double.parse(value!),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
