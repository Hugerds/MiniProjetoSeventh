import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool passwordField;
  const TextFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.passwordField = false,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool obscureText;

  @override
  void initState() {
    obscureText = widget.passwordField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: border,
          errorBorder: border,
          focusedBorder: border,
          enabledBorder: border,
          focusedErrorBorder: border,
          labelText: widget.labelText,
          helperText: "",
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          suffixIcon: widget.passwordField
              ? IconButton(
                  onPressed: () => setState(() => obscureText = !obscureText),
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  OutlineInputBorder get border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      );
}
