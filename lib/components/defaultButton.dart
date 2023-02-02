import 'package:flutter/material.dart';

Widget defaultButton({
  double wid = double.infinity,
  double r = 5.0,
  required String text,
  bool isUpper = true,
  Color back = Colors.green,
  @required function,
}) =>
    Container(
      width: wid,
      height: 50,
      decoration: BoxDecoration(
        color: back,
        borderRadius: BorderRadius.circular(
          r,
        ),
      ),
      child: ElevatedButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
