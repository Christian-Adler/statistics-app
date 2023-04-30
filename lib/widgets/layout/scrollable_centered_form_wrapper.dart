import 'package:flutter/material.dart';

import '../responsive/device_dependent_constrained_box.dart';
import 'center_horizontal.dart';
import 'single_child_scroll_view_with_scrollbar.dart';

/// Wrapper fuer Formulare.<br>
/// Scrollbar, zentriert, Padding und formKey
class ScrollableCenteredFormWrapper extends StatelessWidget {
  final Key formKey;
  final List<Widget> children;

  const ScrollableCenteredFormWrapper({Key? key, required this.formKey, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollViewWithScrollbar(
      child: CenterH(
        child: DeviceDependentConstrainedBox(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
