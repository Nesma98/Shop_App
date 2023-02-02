import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class defaultTextFormFiled extends StatelessWidget {
  defaultTextFormFiled({
    super.key,
    this.onSubmit,
    required this.controller,
    this.type = TextInputType,
    this.isPassword = false,
    this.validate,
    this.SuffixData,
    this.prefixIcon,
    this.label = '',
    this.suffixPressed,
  });
  var controller = TextEditingController();
  var type;
  bool isPassword;
  VoidCallback? suffixPressed;
  String label;
  GestureTapCallback? onTap;
  ValueChanged<String>? onChange;
  ValueChanged<String>? onSubmit;
  IconData? SuffixData;
  IconData? prefixIcon;
  IconData? suffix;
  IconData? prefix;
  FormFieldValidator? validate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () => suffixPressed!(),
          icon: Icon(SuffixData),
        ),
        prefixIcon: Icon(prefixIcon),
        label: Text(label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}

void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
