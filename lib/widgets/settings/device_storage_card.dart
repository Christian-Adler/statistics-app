import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/device_storage.dart';
import 'package:flutter_commons/utils/table_utils.dart';
import 'package:flutter_commons/widgets/text/overflow_text.dart';

import '../../generated/l10n.dart';
import '../../utils/device_storage_keys.dart';
import '../../utils/globals.dart';
import '../controls/card/expandable_settings_card.dart';

class DeviceStorageCard extends StatelessWidget {
  const DeviceStorageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableSettingsCard(
      title: OverflowText(S.of(context).settingsDeviceStorageTitle, style: Theme.of(context).textTheme.titleLarge),
      content: const _DeviceStorage(),
    );
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
              TableUtils.tableHeadline(
                  S.of(context).settingsDeviceStorageTableHeadKey, [S.of(context).settingsDeviceStorageTableHeadValue])
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
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 265,
              child: SwitchListTile(
                value: _showAuthData,
                onChanged: (_) {
                  _toggleShowAuthData();
                },
                title: Text(S.of(context).settingsDeviceStorageLabelShowAuthData),
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
            title: Text(S.of(context).commonsDialogTitleAreYouSure),
            content: Text(S.of(context).settingsDeviceStorageDialogMsgRemoveAllDataAndLogout),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text(S.of(context).commonsDialogBtnNo),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(ctx).pop(true);
                  await Globals.logout(ctx);
                  await DeviceStorage.deleteAll();
                },
                child: Text(S.of(context).commonsDialogBtnYes),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.lock_reset),
      label: Text(S.of(context).settingsDeviceStorageBtnClearStorageAndLogout),
    );
  }
}
