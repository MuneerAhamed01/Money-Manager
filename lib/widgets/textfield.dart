import 'package:flutter/material.dart';
import 'package:money_manager/themes/fonts.dart';

typedef ValidationCallBack = String? Function(String?);

class AppTextField extends StatefulWidget {
  const AppTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.suffix,
      this.label,
      this.error,
      this.validator,
      this.autovalidateMode = AutovalidateMode.onUnfocus,
      this.errorText,
      this.onChanged,
      this.focusNode,
      this.keyboardType = TextInputType.text});

  final TextEditingController? controller;

  final String? hintText;
  final Widget? suffix;
  final String? label;
  final Widget? error;
  final String? errorText;
  final ValidationCallBack? validator;
  final AutovalidateMode autovalidateMode;
  final void Function(String?)? onChanged;
  final FocusNode? focusNode;
  final TextInputType keyboardType;

  @override
  State<AppTextField> createState() => _FMPTextFieldState();
}

class _FMPTextFieldState extends State<AppTextField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (_) => _focusNode.unfocus(),
      child: TextFormField(
        controller: widget.controller,
        style: AppTextTheme.instance.bodyMedium
            ?.copyWith(fontWeight: FontWeight.w400),
        validator: widget.validator,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        autovalidateMode: widget.autovalidateMode,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.suffix,
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          error: widget.error,
          errorText: widget.errorText,
        ),
      ),
    );
  }
}
