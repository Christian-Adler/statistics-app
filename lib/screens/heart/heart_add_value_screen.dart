import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/dialogs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/heart.dart';
import '../../widgets/statistics_app_bar.dart';

class HeartAddValueScreen extends StatefulWidget {
  static const String routeName = '/heart_add_value';

  const HeartAddValueScreen({Key? key}) : super(key: key);

  @override
  State<HeartAddValueScreen> createState() => _HeartAddValueScreenState();
}

class _HeartAddValueScreenState extends State<HeartAddValueScreen> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  int _high = 0;
  int _low = 0;

  void _showSuccessMessage() {
    Dialogs.showSnackBar('gespeichert...', context);
  }

  Future<void> _saveForm() async {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    var power = Provider.of<Heart>(context, listen: false);
    try {
      await power.addBloodPressureEntry(_high, _low);
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
    final insertDate = DateFormat('dd MMMM yyyy - HH:mm:ss').format(DateTime.now());

    return Scaffold(
      appBar: StatisticsAppBar(
        const Text('Blutdruck eintragen'),
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
                  ),
                ),
              ),
            ),
    );
  }
}
