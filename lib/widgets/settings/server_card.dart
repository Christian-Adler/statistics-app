import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/device_storage.dart';
import 'package:flutter_commons/utils/dialogs.dart';
import 'package:flutter_commons/widgets/text/overflow_text.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../providers/auth.dart';
import '../../utils/device_storage_keys.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/globals.dart';
import '../controls/card/expandable_settings_card.dart';

class ServerCard extends StatelessWidget {
  const ServerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return ExpandableSettingsCard(
      title: OverflowText('${S.of(context).settingsServerTitle} (${auth.serverUrl})',
          style: Theme.of(context).textTheme.titleLarge),
      content: const _ChangeServer(),
    );
  }
}

class _ChangeServer extends StatefulWidget {
  const _ChangeServer();

  @override
  State<_ChangeServer> createState() => _ChangeServerState();
}

class _ChangeServerState extends State<_ChangeServer> {
  final _form = GlobalKey<FormState>();
  String _server = '';

  void _showSnackBar(String msg) {
    Dialogs.showSnackBar(msg, context);
  }

  void _goToOverview() {
    Globals.goToHome(context);
  }

  Future<void> _changeServer(String server) async {
    // print('change to server $server');
    final auth = Provider.of<Auth>(context, listen: false);
    final authDataStr = await DeviceStorage.read(DeviceStorageKeys.keyAuthData);
    if (authDataStr == null) {
      auth.logOut();
      return;
    }

    final authData = jsonDecode(authDataStr) as Map<String, dynamic>;
    final p = authData['pw'] as String;

    if (p.isEmpty) {
      auth.logOut();
      return;
    }

    await auth.logIn(server, p);
    _goToOverview();
  }

  Future<void> _saveForm() async {
    var currentState = _form.currentState;
    if (currentState == null || !currentState.validate()) return;
    currentState.save();

    try {
      await _changeServer(_server);
    } catch (err) {
      await DialogUtils.showSimpleOkErrDialog(err.toString(), context);
    }
  }

  void _removeServer(String server) async {
    final snackbarMsgServerRemoved = S.of(context).settingsServerSnackbarMsgServerRemoved;
    try {
      List<String> servers = [];
      var strServers = await DeviceStorage.read(DeviceStorageKeys.keyServers);
      if (strServers != null) {
        servers.addAll((jsonDecode(strServers) as List<dynamic>).map((e) => e.toString()));
      }
      if (servers.remove(server)) {
        await DeviceStorage.write(DeviceStorageKeys.keyServers, jsonEncode(servers));
        _showSnackBar(snackbarMsgServerRemoved);
      }
      setState(() {});
    } catch (err) {
      await DialogUtils.showSimpleOkErrDialog(err.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 10),
        FutureBuilder(
          builder: (ctx, serversSnapshot) {
            if (serversSnapshot.connectionState == ConnectionState.waiting) return Container();
            final storageData = serversSnapshot.data;
            if (storageData == null) return const Text('No servers stored.');
            final servers = [...(jsonDecode(storageData) as List<dynamic>).map((a) => a.toString())];
            return Column(
              children: [
                ...servers.map((serverAddress) {
                  var disabled = (Provider.of<Auth>(ctx, listen: false).serverUrl == serverAddress);
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(serverAddress.startsWith('https') ? Icons.https_outlined : Icons.http),
                    ),
                    trailing: IconButton(
                      onPressed: disabled ? null : () => _removeServer(serverAddress),
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: disabled ? Theme.of(ctx).disabledColor : Theme.of(ctx).colorScheme.error,
                      ),
                    ),
                    title: OutlinedButton(
                      onPressed: () => _changeServer(serverAddress),
                      child: Text(serverAddress),
                    ),
                  );
                })
              ],
            );
          },
          future: DeviceStorage.read(DeviceStorageKeys.keyServers),
        ),
        Form(
          key: _form,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: S.of(context).settingsServerInputLabelServer),
                  textInputAction: TextInputAction.send,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).settingsServerInputValidatorMsgEnterServer;
                    }
                    if (!value.startsWith('http')) {
                      return S.of(context).settingsServerInputValidatorMsgProvideValidServer;
                    }
                    return null;
                  },
                  onSaved: (value) => _server = value!,
                  onEditingComplete: () => _saveForm(),
                ),
              ),
              IconButton(
                  onPressed: () => _saveForm(),
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ],
          ),
        )
      ],
    );
  }
}
