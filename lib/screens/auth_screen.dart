import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_commons/utils/dialogs.dart';
import 'package:provider/provider.dart';

import '../models/navigation/screen_nav_info.dart';
import '../providers/auth.dart';
import '../utils/globals.dart';

class AuthScreen extends StatelessWidget {
  static const ScreenNavInfo screenNavInfo = ScreenNavInfo('Auth', Icons.login, '/auth');

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme
                    .of(context)
                    .colorScheme
                    .primary, Theme
                    .of(context)
                    .colorScheme
                    .secondary
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
              child: SizedBox(
                width: deviceSize.width,
                height: deviceSize.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
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
                  colors: [Colors.purple.withOpacity(0.0), Colors.purple.withOpacity(0.5)],
                ),
              ),
            ),
            Text(
              'Statistics',
              style: TextStyle(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 3),
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
      builder: (ctx) =>
          AlertDialog(
            title: const Text('An Error Occurred'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Okay'))
            ],
          ),
    );
  }

  Future<void> _submit() async {
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
      var errorMessage = 'Could not authenticate you. Please try again later. $err';
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
    final deviceSize = MediaQuery
        .of(context)
        .size;
    return SizedBox(
      width: min(400, deviceSize.width * 0.75),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(top: 7),
                child: TextFormField(
                  decoration: const InputDecoration(
                    isDense: true,
                    // Reduces height a bit
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, // No border
                      // borderRadius: BorderRadius.circular(12), // Apply corner radius
                    ),
                    labelText: 'Server',
                    prefixIcon: Icon(Icons.http),
                  ),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                  // initialValue: 'https://',
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.startsWith('http') || value.length < 10) {
                      return 'Enter a valid server!';
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
              color: Colors.white,
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
                    labelText: 'Password',
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
                      return 'Password is too short!';
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
                child: const Text('LOGIN'),
              ),
          ],
        ),
      ),
    );
  }
}
