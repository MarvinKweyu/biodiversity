import 'package:biocountermobile/core/styles.dart';
import 'package:biocountermobile/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class DefaultTextField extends StatelessWidget {
  final String? label;

  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function? onVisibilityChange;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Function? onTap;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final int? maxLength;
  final bool isLogin;
  final Function? onForgotPasswordPressed;

  const DefaultTextField({
    super.key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.isLogin = false,
    this.keyboardType,
    this.textInputAction,
    this.onVisibilityChange,
    this.validator,
    required this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.inputFormatters,
    this.onSaved,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.onForgotPasswordPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label == ""
                ? const SizedBox()
                : Text(
                    label!,
                    style: Styles.normal(
                      context,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            if (isLogin)
              GestureDetector(
                onTap: () {
                  onForgotPasswordPressed!();
                },
                child: Text(
                  'Forgot Password?',
                  style: Styles.normal(
                    context,
                    fontWeight: FontWeight.w500,
                    fontColor: Styles.primaryColor,
                  ),
                ),
              ),
          ],
        ),
        label == ""
            ? const SizedBox()
            : SizedBox(
                height: screenHeight(context) * 0.012,
              ),
        SizedBox(
          // height: 51.0,
          child: TextFormField(
            autofocus: false,
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              alignLabelWithHint: true,
              hintText: hint,
              hintStyle: Styles.custom16(
                context,
                fontColor: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon ??
                  (onVisibilityChange != null
                      ? IconButton(
                          onPressed: () {
                            onVisibilityChange!();
                          },
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        )
                      : null),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(defaultRadius * 2)),
                borderSide: const BorderSide(
                  color: Styles.primaryColor,
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
              focusColor: Styles.primaryColor,
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(defaultRadius * 2)),
                borderSide: const BorderSide(
                  color: Styles.primaryColor,
                  width: 2.0,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(defaultRadius * 2)),
                borderSide: BorderSide(
                  color: Colors.red.shade400,
                  width: 1.0,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(defaultRadius * 2)),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            readOnly: readOnly,
            validator: validator,
            onChanged: onChanged,
            onSaved: onSaved,
            onFieldSubmitted: onFieldSubmitted,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            textAlignVertical: maxLines != null && minLines != null
                ? TextAlignVertical.top
                : TextAlignVertical.center,
            onTap: () {
              onTap!();
            },
          ),
        ),

      ],
    );
  }
}
