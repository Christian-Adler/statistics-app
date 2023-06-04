import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/device_storage.dart';
import 'package:flutter_commons/utils/table_utils.dart';

import '../../utils/device_storage_keys.dart';
import '../../utils/globals.dart';
import 'settings_card.dart';

class DeviceStorageCard extends StatefulWidget {
  const DeviceStorageCard({Key? key}) : super(key: key);

  @override
  State<DeviceStorageCard> createState() => _DeviceStorageCardState();
}

class _DeviceStorageCardState extends State<DeviceStorageCard> {
  var _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Device Storage', style: Theme.of(context).textTheme.titleLarge),
            IconButton(
              onPressed: () => _toggleExpanded(),
              icon: Icon(_expanded ? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined,
                  color: Theme.of(context).colorScheme.primary),
              visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
            ),
          ],
        ),
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: const _DeviceStorage(),
            secondChild: Container(
              height: 0,
            ),
          ),
        ]);
  }
}

class _DeviceStorage extends StatefulWidget {
  const _DeviceStorage();

  @override
  State<_DeviceStorage> createState() => _DeviceStorageState();
}

class _DeviceStorageState extends State<_DeviceStorage> {
  var _showAuthData = false;

  void _toggleShowAuthData() {
    setState(() {
      _showAuthData = !_showAuthData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 10),
        FutureBuilder(
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
        ),
        const Divider(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            const _ClearDeviceStorage(),
          ],
        ),
      ],
    );
  }
}

class _ClearDeviceStorage extends StatelessWidget {
  const _ClearDeviceStorage();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
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
    );
  }
}
