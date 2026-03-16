// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../utils/Global.colors.dart';

class TextFieldCustom extends StatelessWidget {
  final TextInputType type;
  final IconData icon;
  final Color appColor = GlobalColors.secondaryBtnColorH;
  final bool pass;
  final String label;
  final String hint;
  final double radius = 50;
  TextFieldCustom({
    required this.type,
    required this.icon,
    super.key,
    required this.label,
    required this.hint,
    this.pass = false});
  @override

  @override
  Widget build(BuildContext context) {
    // todo: implement build
    return TextField(
      keyboardType: type,
      obscureText: pass,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: GlobalColors.mediumColorH,
        ), // Icon
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: GlobalColors.lightColorH,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: GlobalColors.lightColorH),
            borderRadius: BorderRadius.all(Radius.circular(radius))), // OutlineInputBorder
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: GlobalColors.mediumColorH),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ), // OutlineInputBorder
      ), // InputDecoration
    ); // TextField
  }
}