import 'package:flutter/material.dart';
import 'package:onboarding_project/layout/HomeScreen.dart';

NavPush(context, Widget) => Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Widget;
      },
    ));

NavPushReplacement(context, Widget) =>
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return Widget;
      },
    ));

NavPop(context) => Navigator.pop(context);
