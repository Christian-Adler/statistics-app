import 'package:flutter/material.dart';

class Tables {
  static TableRow tableHeadline(String key, List<String> values) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Text(
          key,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ...values
          .map(
            (value) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Text(
                value,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .toList(),
    ]);
  }

  static TableRow tableRow(String key, List<dynamic> values) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: Text(key),
      ),
      ...values
          .map(
            (value) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              child: Text(
                value.toString(),
                textAlign: (value is num) ? TextAlign.right : TextAlign.left,
              ),
            ),
          )
          .toList(),
    ]);
  }
}
