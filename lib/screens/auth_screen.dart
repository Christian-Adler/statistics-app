import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/dialogs.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../models/app_info.dart';
import '../models/navigation/screen_nav_info.dart';
import '../providers/auth.dart';
import '../utils/color_utils.dart';
import '../utils/globals.dart';
import '../utils/logging/daily_files.dart';
import '../utils/nav/navigator_transition_builder.dart';
import '../widgets/layout/single_child_scroll_view_with_scrollbar.dart';
import '../widgets/responsive/device_dependent_constrained_box.dart';
import '../widgets/settings/app_language_settings_card.dart';
import 'logs_screen.dart';

class AuthScreen extends StatelessWidget {
  static final ScreenNavInfo screenNavInfo = ScreenNavInfo(
    (ctx) => 'Auth',
    Icons.login,
    '/auth',
    () => const AuthScreen(),
  );

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.settings),
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctx) {
                return const AlertDialog(
                  title: _SettingsDialogTitle(),
                  content: _SettingsDialogContent(),
                );
              });
        },
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: ColorUtils.getThemeGradientColors(context),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                // stops: const [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
              child: SizedBox(
            width: deviceSize.width,
            height: deviceSize.height,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _LoginTitle(),
                SizedBox(height: 20),
                _AuthCard(),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _LoginTitle extends StatelessWidget {
  const _LoginTitle();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 40,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset(
                Globals.assetImgEagleLogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            Image.asset(
              height: 80,
              width: 80,
              Globals.assetImgBackground,
              fit: BoxFit.cover,
            ),
            Container(
              width: 160,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primary.withOpacity(0.0), colorScheme.primary.withOpacity(0.5)],
                ),
              ),
            ),
            Text(
              AppInfo.appName,
              style:
                  TextStyle(color: colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 3),
            ),
          ],
        ),
      ],
    );
  }
}

class _AuthCard extends StatefulWidget {
  const _AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<_AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {
    'server': '',
    'password': '',
  };
  var _isLoading = false;

  final passwordFieldFocusNode = FocusNode();
  var _isObscured = true;

  @override
  void dispose() {
    passwordFieldFocusNode.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(ctx).commonsDialogTitleErrorOccurred),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(S.of(ctx).commonsDialogBtnOkay))
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!context.mounted) return;
    var currentState = _formKey.currentState;
    if (currentState == null || !currentState.validate()) {
      return; // Invalid!
    }
    currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      Dialogs.dismissKeyboard(context);
      await Provider.of<Auth>(context, listen: false).logIn(_authData['server']!, _authData['password']!);
      // } on HttpException catch (err) {
      //   var errorMessage = 'Authentication failed!';
      //   if (err.toString().contains('EMAIL_EXISTS')) {
      //     errorMessage = 'This email address is already in use.';
      //   }
      //   _showErrorDialog(errorMessage);
    } catch (err) {
      var errorMessage = 'Failure during login!';
      if (context.mounted) errorMessage = S.of(context).authErrorMsgAuthenticationFailed;
      // TODO write err to log
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _toggleObscured() {
    setState(() {
      _isObscured = !_isObscured;
      if (passwordFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      passwordFieldFocusNode.canRequestFocus = false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      width: min(400, deviceSize.width * 0.75),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(top: 7),
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    // Reduces height a bit
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none, // No border
                      // borderRadius: BorderRadius.circular(12), // Apply corner radius
                    ),
                    labelText: S.of(context).authInputLabelServer,
                    prefixIcon: const Icon(Icons.http),
                  ),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                  // initialValue: 'https://',
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.startsWith('http') || value.length < 10) {
                      return S.of(context).authInputValidatorMsgEnterValidServer;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value == null) return;
                    _authData['server'] = value;
                  },
                ),
              ),
            ),
            const SizedBox(height: 5),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(top: 7),
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    // Reduces height a bit
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none, // No border
                      // borderRadius: BorderRadius.circular(12), // Apply corner radius
                    ),
                    labelText: S.of(context).authInputLabelPassword,
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                        onPressed: _toggleObscured,
                        icon: Icon(_isObscured ? Icons.visibility_rounded : Icons.visibility_off_rounded)),
                    // suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                  focusNode: passwordFieldFocusNode,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.send,
                  obscureText: _isObscured,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      return S.of(context).authInputValidatorMsgPasswordToShort;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value == null) return;
                    _authData['password'] = value;
                  },
                  onEditingComplete: () => _submit(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _submit,
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  ),
                ),
                child: Text(S.of(context).authBtnLogin),
              ),
          ],
        ),
      ),
    );
  }
}

class _SettingsDialogTitle extends StatelessWidget {
  const _SettingsDialogTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).authSettingsTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close))
      ],
    );
  }
}

class _SettingsDialogContent extends StatelessWidget {
  const _SettingsDialogContent();

  @override
  Widget build(BuildContext context) {
    VoidCallback? showLogsHandler;
    if (DailyFiles.logsDirAvailable()) {
      showLogsHandler =
          () => Navigator.of(context).push(NavigatorTransitionBuilder.buildSlideHTransition(const LogsScreen()));
    }

    return SingleChildScrollViewWithScrollbar(
      child: DeviceDependentConstrainedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Divider(),
            const ChooseLanguage(),
            const Divider(),
            OutlinedButton.icon(
              onPressed: showLogsHandler,
              icon: Icon(LogsScreen.screenNavInfo.iconData),
              label: Text(LogsScreen.screenNavInfo.titleBuilder(context)),
            ),
          ],
        ),
      ),
    );
  }
}
