import 'package:flutter/material.dart';

goTo(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => screen),
  );
}

back(BuildContext context) {
  Navigator.pop(context);
}
