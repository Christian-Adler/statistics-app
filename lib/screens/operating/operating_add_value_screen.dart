import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/dialogs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:statistics/utils/date_utils.dart';

import '../../models/exception/api_exception.dart';
import '../../models/screen_nav_info.dart';
import '../../providers/operating.dart';
import '../../widgets/statistics_app_bar.dart';

class OperatingAddValueScreen extends StatefulWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Betriebskosten eintragen', Icons.add, '/operating/add');

  const OperatingAddValueScreen({Key? key}) : super(key: key);

  @override
  State<OperatingAddValueScreen> createState() => _OperatingAddValueScreenState();
}

class _OperatingAddValueScreenState extends State<OperatingAddValueScreen> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  double _water = 0.0;
  double _consumedPower = 0.0;
  double _feedPower = 0.0;
  double _heatingHT = 0.0;
  double _heatingNT = 0.0;

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
      await power.addOperatingEntry(_water, _consumedPower, _feedPower, _heatingHT, _heatingNT);
      _showSuccessMessage();
    } on ApiException catch (err) {
      await Dialogs.simpleOkDialog(err.message, context, title: 'Fehler');
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
        Text(OperatingAddValueScreen.screenNavInfo.title),
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
                        onEditingComplete: () => _saveForm(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
