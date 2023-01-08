import 'package:flutter/material.dart';
import 'package:apartment_app/shared/shared_theme/shared_colors.dart';
import 'package:apartment_app/shared/shared_theme/shared_fonts.dart';

enum FieldType { email, password, text }

class FieldModel {
  final String? labelTxt;
  final String? hintTxt;
  final IconData? icon;
  final TextInputType? type;
  TextEditingController? controller;
  bool? isSecure;
  final FieldType? fieldType;
  bool? enabled;
  final Key? key;
  Function? onsumbit = () {};

  FieldModel(
      {this.labelTxt = '',
      this.hintTxt = '',
      this.icon,
      this.type,
      this.controller,
      this.isSecure = false,
      this.fieldType = FieldType.text,
      this.enabled = true,
      this.onsumbit,
      this.key});
}

class CustomField extends StatefulWidget {
  final FieldModel model;
  const CustomField(this.model, {super.key});

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        key: widget.model.key,
        validator: (x) {
          if (x!.isEmpty) {
            return 'This Field Required';
          }
        },
        decoration: InputDecoration(
            border: fieldBorder(SharedColors.greyColor),
            errorBorder: fieldBorder(Colors.red),
            focusedBorder: fieldBorder(SharedColors.greyColor),
            focusedErrorBorder: fieldBorder(Colors.red),
            disabledBorder: fieldBorder(Colors.transparent),
            prefixIcon: Icon(widget.model.icon, color: SharedColors.greyColor),
            labelText: widget.model.labelTxt,
            labelStyle: SharedFonts.subGreyFont,
            hintText: widget.model.hintTxt,
            hintStyle: SharedFonts.subGreyFont,
            suffixIcon: widget.model.fieldType == FieldType.password
                ? IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    color: SharedColors.greyColor,
                    iconSize: 20.0,
                    onPressed: () {
                      setState(() {
                        widget.model.isSecure = !widget.model.isSecure!;
                      });
                    },
                  )
                : null),
        keyboardType: widget.model.type,
        controller: widget.model.controller,
        obscureText: widget.model.isSecure!,
        enabled: widget.model.enabled,
        onFieldSubmitted: (x) {
          widget.model.onsumbit!();
        },
      ),
    );
  }
}

OutlineInputBorder fieldBorder(Color color) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(color: color, width: 1.0));
}
