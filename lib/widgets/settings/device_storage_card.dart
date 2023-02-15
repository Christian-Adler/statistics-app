import 'package:flutter/material.dart';
import 'package:statistics/models/device_storage.dart';
import 'package:statistics/widgets/settings/settings_card.dart';

import '../../models/globals.dart';

class DeviceStorageCard extends StatelessWidget {
  const DeviceStorageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsCard(
      title: 'Device Storage',
      children: [
        _ShowDeviceStorage(),
        Divider(height: 10),
        _ClearDeviceStorage(),
      ],
    );
  }
}

class _ShowDeviceStorage extends StatefulWidget {
  const _ShowDeviceStorage();

  @override
  State<_ShowDeviceStorage> createState() => _ShowDeviceStorageState();
}

class _ShowDeviceStorageState extends State<_ShowDeviceStorage> {
  var _showDeviceStorage = false;

  void _toggleShowDeviceStorage() {
    setState(() {
      _showDeviceStorage = !_showDeviceStorage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
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

class _ClearDeviceStorage extends StatelessWidget {
  const _ClearDeviceStorage();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton.icon(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you really want to remove all data from device and log out?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(ctx).pop(true);
                      await Globals.logout(ctx);
                      await DeviceStorage.deleteAll();
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.lock_reset),
          label: const Text('clear storage & logout'),
        ),
      ],
    );
  }
}
