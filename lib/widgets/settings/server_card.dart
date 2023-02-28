import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../utils/device_storage.dart';
import '../../utils/device_storage_keys.dart';
import '../../utils/dialogs.dart';
import '../../utils/globals.dart';
import 'settings_card.dart';

class ServerCard extends StatefulWidget {
  const ServerCard({Key? key}) : super(key: key);

  @override
  State<ServerCard> createState() => _ServerCardState();
}

class _ServerCardState extends State<ServerCard> {
  var _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return SettingsCard(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Server', style: Theme.of(context).textTheme.titleLarge),
            IconButton(
              onPressed: () => _toggleExpanded(),
              icon: Icon(_expanded ? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined,
                  color: Theme.of(context).colorScheme.primary),
              visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
            ),
          ],
        ),
        children: [
          Text(auth.serverUrl),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: _ChangeServer(expanded: _expanded),
            secondChild: Container(
              height: 0,
            ),
          ),
        ]);
  }
}

class _ChangeServer extends StatefulWidget {
  final bool expanded;

  const _ChangeServer({required this.expanded});

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
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    try {
      await _changeServer(_server);
    } catch (err) {
      await Dialogs.simpleOkDialog(err.toString(), context, title: 'Fehler');
    }
  }

  void _removeServer(String server) async {
    try {
      List<String> servers = [];
      var strServers = await DeviceStorage.read(DeviceStorageKeys.keyServers);
      if (strServers != null) {
        servers.addAll((jsonDecode(strServers) as List<dynamic>).map((e) => e.toString()));
      }
      if (servers.remove(server)) {
        await DeviceStorage.write(DeviceStorageKeys.keyServers, jsonEncode(servers));
        _showSnackBar('Server entfernt...');
      }
      setState(() {});
    } catch (err) {
      await Dialogs.simpleOkDialog(err.toString(), context, title: 'Fehler');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 10),
        FutureBuilder(
          builder: (context, serversSnapshot) {
            if (serversSnapshot.connectionState == ConnectionState.waiting) return Container();
            final storageData = serversSnapshot.data;
            if (storageData == null) return const Text('No servers stored.');
            final servers = [...(jsonDecode(storageData) as List<dynamic>).map((a) => a.toString())];
            return Column(
              children: [
                ...servers.map((serverAddress) {
                  var disabled = (Provider.of<Auth>(context, listen: false).serverUrl == serverAddress);
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(serverAddress.startsWith('https') ? Icons.https_outlined : Icons.http),
                    ),
                    trailing: IconButton(
                      onPressed: disabled ? null : () => _removeServer(serverAddress),
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: disabled ? Theme.of(context).disabledColor : Theme.of(context).colorScheme.error,
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
          future: !widget.expanded ? Future.value('[]') : DeviceStorage.read(DeviceStorageKeys.keyServers),
        ),
        Form(
          key: _form,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Server'),
                  textInputAction: TextInputAction.send,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter a server';
                    if (!value.startsWith('http')) return 'Please provide a valid server address';
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
