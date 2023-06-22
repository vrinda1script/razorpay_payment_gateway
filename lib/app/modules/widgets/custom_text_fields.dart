// ignore_for_file: deprecated_member_use
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_errors.dart';
import '../../constants/app_string.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextStyle {
  static TextStyle inputStyle = Get.textTheme.headlineLarge!.copyWith(
    color: AppColors.appBlackColor,
    fontWeight: FontWeight.w500,
  );
}

class UniversalTextField extends StatelessWidget with CustomDecorationMixin {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final String validationMessageOnBlankText;

  // Dafault false, If true make the text field un-editable.
  final bool readOnly;
  final String validatorErrorText;
  final String? initialValue;
  final int lengthToValidate;

  /// Define how many lines you willl required?
  final int? maxLines;
  final int? maxLength;
  final Widget? suffixIcon;
  final TextStyle? style;
  final bool denySpaces;
  final bool? isUnderlineBorder;
  final AutovalidateMode? validationMode;
  final EdgeInsets? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  const UniversalTextField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.validatorErrorText,
    required this.validationMessageOnBlankText,
    this.readOnly = false,
    this.lengthToValidate = 2,
    this.maxLines,
    this.suffixIcon,
    this.style,
    this.initialValue,
    this.maxLength,
    this.denySpaces = false,
    this.validationMode,
    this.isUnderlineBorder,
    this.contentPadding,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: AppColors.appBlackColor,
      initialValue: initialValue,
      readOnly: readOnly,
      maxLines: maxLines ?? 1,
      decoration: customDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        isUnderlineBorder: isUnderlineBorder,
        contentPadding: contentPadding,
      ),
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      style: style ?? InputTextStyle.inputStyle,
      validator: (value) => GetUtils.isBlank(value)!
          ? validationMessageOnBlankText
          : value!.length >= (lengthToValidate)
              ? null
              : validatorErrorText,
      autovalidateMode: validationMode,
    );
  }
}

class EmailTextField extends StatelessWidget with CustomDecorationMixin {
  final TextEditingController controller;
  final bool readOnly;
  final String? hintText;
  final Widget? suffixIcon;
  final bool denySpaces;

  const EmailTextField({
    Key? key,
    required this.controller,
    this.readOnly = false,
    this.hintText,
    this.suffixIcon,
    this.denySpaces = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      cursorColor: AppColors.appBlackColor,
      readOnly: readOnly,
      validator: (email) =>
          GetUtils.isEmail(email.toString()) ? null : AppErrors.emailErrorText,
      decoration: customDecoration(
        hintText: hintText ?? AppStrings.email,
        suffixIcon: suffixIcon,
      ),
      inputFormatters: [
        if (denySpaces)
          FilteringTextInputFormatter.deny(
            RegExp(r'\s'),
          ),
      ],
      style: InputTextStyle.inputStyle,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

class PhoneTextField extends StatelessWidget with CustomDecorationMixin {
  final TextEditingController controller;
  final bool readOnly;
  final String? hintText;
  final Widget? suffixIcon;
  final TextStyle? style;
  final int? maxLength;

  const PhoneTextField(
      {Key? key,
      this.style,
      required this.controller,
      this.readOnly = false,
      this.suffixIcon,
      this.hintText,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      cursorColor: AppColors.appBlackColor,
      readOnly: readOnly,
      maxLength: maxLength,
      validator: (phoneNumber) => GetUtils.isPhoneNumber(phoneNumber.toString())
          ? null
          : AppErrors.phoneNumberErrorText,
      decoration: customDecoration(
        hintText: hintText ?? AppStrings.phoneNumber,
        suffixIcon: suffixIcon,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(r'\s'),
        ),
      ],
      style: style ?? InputTextStyle.inputStyle,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

class PasswordTextField extends StatelessWidget with CustomDecorationMixin {
  final TextEditingController controller;
  final String? hintText;
  final bool readOnly;
  final bool isObSecure;
  final Widget? suffixIcon;
  final bool denySpaces;
  final TextStyle? style;

  PasswordTextField({
    Key? key,
    this.style,
    required this.controller,
    this.hintText,
    this.readOnly = false,
    this.suffixIcon,
    this.isObSecure = true,
    this.denySpaces = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      cursorColor: AppColors.appBlackColor,
      readOnly: readOnly,
      obscureText: isObSecure,
      validator: (password) {
        password ??= '';
        if (password.length < 8) {
          return AppErrors.passwordLengthErrorText;
        } else {
          return null;
        }
      },
      decoration: customDecoration(
        hintText: hintText ?? AppStrings.enterPassword,
        suffixIcon: suffixIcon,
      ),
      inputFormatters: [
        if (denySpaces)
          FilteringTextInputFormatter.deny(
            RegExp(r'\s'),
          ),
      ],
      style: style ?? InputTextStyle.inputStyle,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

class SearchTextField extends StatelessWidget with CustomDecorationMixin {
  final void Function(String) search;
  final void Function()? onCancellingSearch;
  final bool readOnly;
  final bool isAlsoSearchOnChange;
  final String? hintText;
  final TextEditingController controller;
  final RxBool _isShowClearTextIcon = false.obs;
  final TextInputType? keyboardType;

  SearchTextField({
    Key? key,
    required this.search,
    this.readOnly = false,
    this.isAlsoSearchOnChange = false,
    this.hintText,
    this.onCancellingSearch,
    required this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      readOnly: readOnly,
      cursorColor: AppColors.appBlackColor,
      onFieldSubmitted: search,
      onChanged: (value) {
        if (isAlsoSearchOnChange) {
          search(value);
        }
        if (value.isNotEmpty) {
          _isShowClearTextIcon.value = true;
        } else {
          _isShowClearTextIcon.value = false;
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.appWhiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: .5,
            color: AppColors.appGreenThemeColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.appGreenThemeColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.appGreenThemeColor,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: hintText ?? AppStrings.search,
        suffixIcon: Obx(
          () => SizedBox(
            width: Get.width * .35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_isShowClearTextIcon.value)
                  IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: AppColors.appBlackColor.withOpacity(.7),
                    ),
                    onPressed: () {
                      controller.clear();
                      _isShowClearTextIcon.value = false;
                      FocusManager.instance.primaryFocus!.unfocus();
                      if (onCancellingSearch != null) {
                        onCancellingSearch!();
                      }
                    },
                  ),
                if (_isShowClearTextIcon.value)
                  Container(
                    width: 1,
                    height: 25,
                    color: AppColors.appBlackColor.withOpacity(.5),
                  ),
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: AppColors.appGreenThemeColor,
                  ),
                  onPressed: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    search(controller.text);
                  },
                ),
                const SizedBox(width: 5)
              ],
            ),
          ),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

mixin CustomDecorationMixin {
  InputDecoration customDecoration({
    required String hintText,
    bool? isUnderlineBorder,
    Widget? suffixIcon,
    EdgeInsets? contentPadding,
  }) {
    return InputDecoration(
      fillColor: AppColors.appWhiteColor,
      filled: true,
      border: isUnderlineBorder ?? false
          ? const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.greyBorderColor,
              ),
            )
          : const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyBorderColor),
            ),
      enabledBorder: isUnderlineBorder ?? false
          ? const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.greyBorderColor,
              ),
            )
          : const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyBorderColor),
            ),
      focusedBorder: isUnderlineBorder ?? false
          ? const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.greyBorderColor,
              ),
            )
          : const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyBorderColor),
            ),
      isDense: true,
      contentPadding: contentPadding ?? const EdgeInsets.all(10),
      hintText: hintText,
      hintStyle: InputTextStyle.inputStyle,
      suffixIcon: suffixIcon,
      counterText: "",
    );
  }
}
