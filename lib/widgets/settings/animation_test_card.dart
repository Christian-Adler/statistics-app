import 'package:flutter/material.dart';

import '../controls/card/settings_card.dart';

class AnimationTestCard extends StatelessWidget {
  const AnimationTestCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsCard(
      title: 'Animation Test',
      children: [
        _AnimationTest(),
      ],
    );
  }
}

class _AnimationTest extends StatefulWidget {
  const _AnimationTest();

  @override
  State<_AnimationTest> createState() => _AnimationTestState();
}

class _AnimationTestState extends State<_AnimationTest> {
  var _toggle = false;

  void _toggleState() {
    setState(() {
      _toggle = !_toggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton.icon(
          onPressed: _toggleState,
          icon: Icon(_toggle ? Icons.visibility_off_rounded : Icons.visibility_rounded),
          label: Text(_toggle ? 'hide' : 'show'),
        ),
        // if (_showDeviceStorage)

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _toggle ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Container(
            height: 20,
            color: Colors.greenAccent,
          ),
          secondChild: Container(
            height: 50,
            color: Colors.redAccent,
          ),
        )
      ],
    );
  }
}
