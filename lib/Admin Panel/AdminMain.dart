import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'Screens/AdminLoginScreen.dart';

class AdminMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition:Transition.rightToLeft,
      home: AdminLogin(),
    );
  }
}

