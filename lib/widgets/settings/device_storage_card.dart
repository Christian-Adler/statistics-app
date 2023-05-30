import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/device_storage.dart';
import 'package:flutter_commons/utils/table_utils.dart';

import '../../utils/device_storage_keys.dart';
import '../../utils/globals.dart';
import 'settings_card.dart';

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
  var _showAuthData = false;

  void _toggleShowDeviceStorage() {
    setState(() {
      _showDeviceStorage = !_showDeviceStorage;
    });
  }

  void _toggleShowAuthData() {
    setState(() {
      _showAuthData = !_showAuthData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton.icon(
              onPressed: _toggleShowDeviceStorage,
              icon: Icon(_showDeviceStorage ? Icons.visibility_off_rounded : Icons.visibility_rounded),
              label: Text(_showDeviceStorage ? 'hide storage' : 'show storage'),
            ),
            if (_showDeviceStorage)
              SizedBox(
                width: 200,
                child: SwitchListTile(
                  value: _showAuthData,
                  onChanged: (_) {
                    _toggleShowAuthData();
                  },
                  title: const Text('Login-Daten'),
                ),
              ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: Container(
            child: _showDeviceStorage
                ? FutureBuilder(
                    builder: (context, deviceStorageSnapshot) {
                      if (deviceStorageSnapshot.connectionState == ConnectionState.waiting) {
                        return const LinearProgressIndicator();
                      }

                      final storageData = deviceStorageSnapshot.data;
                      if (storageData == null) return const Text('No device storage data set.');

                      List<TableRow> rows = [
                        TableUtils.tableHeadline('Key', ['Value'])
                      ];

                      final keys = storageData.keys.toList();
                      keys.sort();
                      for (var key in keys) {
                        var value = storageData[key];
                        if (key == DeviceStorageKeys.keyAuthData && !_showAuthData) {
                          value = '{--}';
                        }
                        rows.add(TableUtils.tableRow(key, [value ?? '-']));
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
                  )
                : null,
          ),
        ),
      ],
    );
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
