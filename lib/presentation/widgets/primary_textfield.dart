import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ez_parking_app/core/framework/constants.dart';

class PrimaryTextfield extends StatefulWidget {
  const PrimaryTextfield({
    Key? key,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.autofillHints = const [],
    this.required = false,
    this.textCapitalization = TextCapitalization.none,
    this.customValidator,
    this.enableSuggestions = true,
    this.autofocus = false,
    this.enable = true,
    this.hintText = '',
    this.maxLines = 1,
    this.prefixIcon,
    this.verticalMargin = 10,
    this.horizontalMargin = HORIZONTAL_MARGIN,
    this.onChanged,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.onTap,
    this.height,
    this.fontSize,
  }) : super(key: key);

  final bool obscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController controller;
  final Iterable<String> autofillHints;
  final bool required;
  final TextCapitalization textCapitalization;
  final String? Function(String)? customValidator;
  final bool enableSuggestions;
  final bool autofocus;
  final bool enable;
  final String hintText;
  final int maxLines;
  final Icon? prefixIcon;
  final double verticalMargin;
  final double horizontalMargin;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final double? height;
  final double? fontSize;

  @override
  _PrimaryTextfieldState createState() => _PrimaryTextfieldState();
}

class _PrimaryTextfieldState extends State<PrimaryTextfield> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: widget.verticalMargin, horizontal: widget.horizontalMargin),
      height: widget.height,
      child: TextFormField(
        controller: widget.controller,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        autofillHints: widget.enable ? widget.autofillHints : null,
        autocorrect: false,
        enableSuggestions: false,
        enabled: widget.enable,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        inputFormatters: widget.inputFormatters,
        obscureText: obscureText,
        textCapitalization: widget.textCapitalization,
        maxLines: widget.maxLines,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          hintText: widget.hintText,
          hintStyle: widget.fontSize == null
              ? null
              : Theme.of(context).textTheme.bodyText1!.merge(TextStyle(fontSize: widget.fontSize)),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obscureText
              ? GestureDetector(
                  onTapUp: (settings) {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: obscureText
                      ? Icon(Icons.visibility_outlined, color: Theme.of(context).iconTheme.color)
                      : Icon(Icons.visibility_off_outlined, color: Theme.of(context).iconTheme.color),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
        validator: (text) {
          if ((text == null || text.isEmpty) && widget.required) {
            return 'Este campo es requerido';
          }
          if (widget.customValidator != null) {
            return widget.customValidator!(text!);
          }
          return null;
        },
        onChanged: widget.onChanged,
      ),
    );
  }
}
