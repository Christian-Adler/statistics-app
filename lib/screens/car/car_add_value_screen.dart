import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/dialogs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/exception/api_exception.dart';
import '../../models/screen_nav_info.dart';
import '../../providers/car.dart';
import '../../widgets/statistics_app_bar.dart';

class CarAddValueScreen extends StatefulWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Tanken eintragen', Icons.add, '/car/add');

  const CarAddValueScreen({Key? key}) : super(key: key);

  @override
  State<CarAddValueScreen> createState() => _CarAddValueScreenState();
}

class _CarAddValueScreenState extends State<CarAddValueScreen> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  double _liter = 0.0;
  double _centPerLiter = 0.0;
  double _km = 0.0;

  void _showSuccessMessage() {
    Dialogs.showSnackBar('gespeichert...', context);
  }

  Future<void> _saveForm() async {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    var power = Provider.of<Car>(context, listen: false);
    try {
      await power.addCarRefuelEntry(_liter, _centPerLiter, _km);
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
    final insertDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    return Scaffold(
      appBar: StatisticsAppBar(
        Text(CarAddValueScreen.screenNavInfo.title),
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
                        decoration: const InputDecoration(labelText: 'Liter (gerundet)'),
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter a value';
                          var val = double.tryParse(value);
                          if (val == null || val <= 0) return 'Please provide a valid number > 0';
                          return null;
                        },
                        onSaved: (value) => _liter = double.parse(value!),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'ct/l (1,199€ = 120ct/l)'),
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter a value';
                          var val = double.tryParse(value);
                          if (val == null || val <= 0) return 'Please provide a valid number > 0';
                          return null;
                        },
                        onSaved: (value) => _centPerLiter = double.parse(value!),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'km-Stand'),
                        textInputAction: TextInputAction.done,
                        keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please enter a value';
                          var val = double.tryParse(value);
                          if (val == null || val <= 0) return 'Please provide a valid number > 0';
                          return null;
                        },
                        onSaved: (value) => _km = double.parse(value!),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
