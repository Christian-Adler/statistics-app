import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statistics/models/device_storage.dart';

import '../../models/globals.dart';
import '../../providers/auth.dart';

class DeviceStorageCard extends StatefulWidget {
  const DeviceStorageCard({Key? key}) : super(key: key);

  @override
  State<DeviceStorageCard> createState() => _DeviceStorageCardState();
}

class _DeviceStorageCardState extends State<DeviceStorageCard> {
  var _showDeviceStorage = false;

  void _toggleShowDeviceStorage() {
    setState(() {
      _showDeviceStorage = !_showDeviceStorage;
    });
  }

  void _hideShowDeviceStorage() {
    setState(() {
      _showDeviceStorage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Storage',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            OutlinedButton.icon(
              onPressed: _toggleShowDeviceStorage,
              icon: Icon(_showDeviceStorage ? Icons.visibility_off_rounded : Icons.visibility_rounded),
              label: Text(_showDeviceStorage ? 'hide storage' : 'show storage'),
            ),
            if (_showDeviceStorage)
              FutureBuilder(
                builder: (context, deviceStorageSnapshot) {
                  if (deviceStorageSnapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }

                  final storageData = deviceStorageSnapshot.data;
                  if (storageData == null) return const Text('No device storage data set.');

                  List<TableRow> rows = [_tableHeadline('Key', 'Value')];

                  final keys = storageData.keys.toList();
                  keys.sort();
                  for (var key in keys) {
                    final value = storageData[key];
                    rows.add(_tableRow(key, value ?? '-'));
                  }

                  return Table(
                    // https://api.flutter.dev/flutter/widgets/Table-class.html
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(128), // IntrinsicColumnWidth(),
                      1: FlexColumnWidth(),
                    },
                    border: TableBorder.symmetric(
                      inside: const BorderSide(width: 1, color: Colors.black12),
                    ),
                    children: rows,
                  );
                },
                future: DeviceStorage.readAll(),
              ),
            const Divider(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () async {
                    await Globals.logout(context);
                    await DeviceStorage.deleteAll();
                  },
                  icon: const Icon(Icons.lock_reset),
                  label: const Text('clear storage & logout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _tableHeadline(String key, String value) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Text(
          key,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ]);
  }

  TableRow _tableRow(String key, String value) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: Text(key),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: Text(value),
      )
    ]);
  }
}
