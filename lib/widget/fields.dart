import 'package:flutter/material.dart';

class TextEntry extends StatelessWidget {
  final TextEditingController controller;
  final String labeltext;
  final IconData iconData;
  final bool obscuretext;
  final IconButton iconButton;
  final Function validation;
  final TextInputType ktype;
  final bool borderr;
  TextEntry(
      {this.controller,
      this.iconData,
      this.labeltext,
      this.obscuretext,
      this.iconButton,
      this.validation,this.ktype,this.borderr});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation,
      obscureText: obscuretext ?? false,
      controller: controller,
      keyboardType: ktype,
      decoration: InputDecoration(
        border: borderr==true? OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide(width: 5)):null,
          prefixIcon: Icon(iconData),
          suffixIcon: iconButton,
          labelText: labeltext),
    );
  }
}
