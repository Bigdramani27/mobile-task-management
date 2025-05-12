import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kowri/helpers/colors.dart';
import 'package:kowri/helpers/size.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final void Function()? onTap;
  final bool isLoading;
  final Color? color;
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.isLoading = false,
    this.color,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: widget.color ?? primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: widget.isLoading
              ? const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    color: background,
                  ),
                )
              : CustomText(
                  text: widget.text,
                  fontWeight: FontWeight.w600,
                  color: background,
                  size: h3,
                ),
        ),
      ),
    );
  }
}

class TransparentCustomButton extends StatefulWidget {
  final String text;
  final void Function()? onTap;
  const TransparentCustomButton({super.key, required this.text, this.onTap});

  @override
  State<TransparentCustomButton> createState() => _TransparentCustomButtonState();
}

class _TransparentCustomButtonState extends State<TransparentCustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(color: transparent, borderRadius: BorderRadius.circular(10), border: Border.all(color: primary)),
        child: Center(
            child: CustomText(
          text: widget.text,
          fontWeight: FontWeight.w600,
          color: primary,
          size: h3,
        )),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final List<Shadow>? shadow;
  const CustomText({super.key, required this.text, this.fontWeight, this.color, this.size, this.shadow, this.textAlign, this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(fontWeight: fontWeight, color: color, fontSize: size, shadows: shadow),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final bool? enabled;
  final double? borderRadius;
  final double? width;
  final double? specialHeight;
  final int? minLines;
  final int? maxLines;
  final EdgeInsetsGeometry? containerPadding;
  final String hintText;
  final Color? color;
  final Color? borderColor;
  final TextEditingController controller;
  final VoidCallback onTap;
  final String title;
  final double size;
  final FontWeight weight;
  final EdgeInsets? margin;
  final VoidCallback? iconOnTap;
  final IconData? icon;
  final double? iconSize;
  final FocusNode? focusNode;
  final IconData prefix;
  final int? maxLength;
  final TextInputType? keyboardType;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onTap,
    required this.title,
    required this.size,
    required this.weight,
    this.margin,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.containerPadding,
    this.width,
    this.minLines,
    this.maxLines,
    this.specialHeight,
    this.iconOnTap,
    this.icon,
    this.iconSize,
    this.focusNode,
    this.enabled,
    required this.prefix,
    this.keyboardType,
    this.maxLength,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: widget.margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: widget.title,
              size: h2,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 4,
            ),
            TextFields(
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              enabled: widget.enabled,
              focusNode: widget.focusNode,
              specialHeight: widget.specialHeight,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              controller: widget.controller,
              hintText: widget.hintText,
              width: widget.width ?? 380,
              color: widget.color,
              borderColor: widget.borderColor,
              borderRadius: widget.borderRadius,
              padding: widget.containerPadding,
              icon: widget.prefix,
            )
          ],
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  final bool? enabled;

  final double? borderRadius;
  final int? minLines;
  final int? maxLines;
  final Color? borderColor;
  final Color? color;
  final double? width;
  final double? specialHeight;
  final EdgeInsetsGeometry? padding;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final IconData icon;
  final int? maxLength;
  final TextInputType? keyboardType;

  const TextFields({
    super.key,
    required this.controller,
    required this.hintText,
    this.width,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.minLines,
    this.maxLines,
    this.specialHeight,
    this.focusNode,
    this.enabled,
    required this.icon,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        border: Border.all(
          color: borderColor ?? grey,
          width: 1,
        ),
      ),
      child: SizedBox(
        height: specialHeight ?? 50,
        width: width,
        child: TextFormField(
          maxLength: maxLength,
          keyboardType: keyboardType,
          enabled: enabled,
          focusNode: focusNode,
          minLines: minLines ?? 1,
          maxLines: maxLines ?? 1,
          cursorColor: black,
          cursorHeight: 20,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 13),
            hintText: hintText,
            counterText: '',
            hintStyle: const TextStyle(
              color: grey, // Set hint text color
            ),
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  icon,
                  color: greyText,
                  size: 16,
                ),
              ],
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class PasswordCustomTextField extends StatefulWidget {
  final bool? enabled;
  final double? borderRadius;
  final double? width;
  final double? specialHeight;
  final int? minLines;
  final int? maxLines;
  final EdgeInsetsGeometry? containerPadding;
  final String hintText;
  final Color? color;
  final Color? borderColor;
  final TextEditingController controller;
  final VoidCallback onTap;
  final String title;
  final double size;
  final FontWeight weight;
  final EdgeInsets? margin;
  final VoidCallback iconOnTap;
  final IconData? icon;
  final double? iconSize;
  final FocusNode? focusNode;
  final IconData prefix;
  final IconData suffix;
  final bool obscureText;
  const PasswordCustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onTap,
    required this.title,
    required this.size,
    required this.weight,
    this.margin,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.containerPadding,
    this.width,
    this.minLines,
    this.maxLines,
    this.specialHeight,
    required this.iconOnTap,
    this.icon,
    this.iconSize,
    this.focusNode,
    this.enabled,
    required this.prefix,
    required this.obscureText,
    required this.suffix,
  });

  @override
  State<PasswordCustomTextField> createState() => _PasswordCustomTextFieldState();
}

class _PasswordCustomTextFieldState extends State<PasswordCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: widget.title,
            size: h2,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 7,
          ),
          PasswordTextField(enabled: widget.enabled, focusNode: widget.focusNode, specialHeight: widget.specialHeight, minLines: widget.minLines, maxLines: widget.maxLines, controller: widget.controller, hintText: widget.hintText, width: widget.width ?? 380, color: widget.color, borderColor: widget.borderColor, borderRadius: widget.borderRadius, padding: widget.containerPadding, icon: widget.suffix, obscureText: widget.obscureText, leftIcon: widget.prefix, suffixOnTap: widget.iconOnTap),
        ],
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final bool? enabled;

  final double? borderRadius;
  final int? minLines;
  final int? maxLines;
  final Color? borderColor;
  final Color? color;
  final double? width;
  final double? specialHeight;
  final EdgeInsetsGeometry? padding;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final IconData icon;
  final IconData leftIcon;
  final void Function() suffixOnTap;
  final bool obscureText;

  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.width,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.minLines,
    this.maxLines,
    this.specialHeight,
    this.focusNode,
    this.enabled,
    required this.icon,
    required this.obscureText,
    required this.leftIcon,
    required this.suffixOnTap,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
        border: Border.all(
          color: widget.borderColor ?? grey,
          width: 1,
        ),
      ),
      child: SizedBox(
        height: widget.specialHeight ?? 50,
        width: widget.width,
        child: TextFormField(
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          focusNode: widget.focusNode,
          minLines: widget.minLines ?? 1,
          maxLines: widget.maxLines ?? 1,
          cursorColor: black,
          cursorHeight: 20,
          controller: widget.controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 13),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: grey,
            ),
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  widget.leftIcon,
                  color: greyText,
                  size: 16,
                ),
              ],
            ),
            suffixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: widget.suffixOnTap,
                  child: FaIcon(
                    widget.icon,
                    color: primary,
                    size: 16,
                  ),
                ),
              ],
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class MessageTextField extends StatefulWidget {
  final bool? enabled;
  final double? borderRadius;
  final Color? borderColor;
  final Color? color;
  final double? width;
  final double? specialHeight;
  final EdgeInsetsGeometry? padding;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String title;

  const MessageTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.width,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.specialHeight,
    this.focusNode,
    this.enabled,
    required this.title,
  });

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.title,
          size: h2,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            border: Border.all(
              color: widget.borderColor ?? grey,
              width: 1,
            ),
          ),
          child: SizedBox(
            height: widget.specialHeight ?? 50,
            width: widget.width,
            child: TextFormField(
              enabled: widget.enabled,
              focusNode: widget.focusNode,
              minLines: 1,
              maxLines: null,
              cursorColor: black,
              cursorHeight: 20,
              controller: widget.controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: grey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CreateTaskTextField extends StatefulWidget {
  final bool? enabled;
  final double? borderRadius;
  final double? width;
  final double? specialHeight;
  final int? minLines;
  final int? maxLines;
  final EdgeInsetsGeometry? containerPadding;
  final String hintText;
  final Color? color;
  final Color? borderColor;
  final TextEditingController controller;
  final VoidCallback onTap;
  final String title;
  final double size;
  final FontWeight weight;
  final EdgeInsets? margin;
  final FocusNode? focusNode;
  final int? maxLength;
  final TextInputType? keyboardType;
  const CreateTaskTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onTap,
    required this.title,
    required this.size,
    required this.weight,
    this.margin,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.containerPadding,
    this.width,
    this.minLines,
    this.maxLines,
    this.specialHeight,
    this.focusNode,
    this.enabled,
    this.keyboardType,
    this.maxLength,
  });

  @override
  State<CreateTaskTextField> createState() => _CreateTaskTextFieldState();
}

class _CreateTaskTextFieldState extends State<CreateTaskTextField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: widget.margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: widget.title,
              size: h2,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 4,
            ),
            CreateTextField(
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              enabled: widget.enabled,
              focusNode: widget.focusNode,
              specialHeight: widget.specialHeight,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              controller: widget.controller,
              hintText: widget.hintText,
              width: widget.width ?? 380,
              color: widget.color,
              borderColor: widget.borderColor,
              borderRadius: widget.borderRadius,
              padding: widget.containerPadding,
            )
          ],
        ),
      ),
    );
  }
}

class CreateTextField extends StatelessWidget {
  final bool? enabled;
  final double? borderRadius;
  final int? minLines;
  final int? maxLines;
  final Color? borderColor;
  final Color? color;
  final double? width;
  final double? specialHeight;
  final EdgeInsetsGeometry? padding;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final int? maxLength;
  final TextInputType? keyboardType;

  const CreateTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.width,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.minLines,
    this.maxLines,
    this.specialHeight,
    this.focusNode,
    this.enabled,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        border: Border.all(
          color: borderColor ?? grey,
          width: 1,
        ),
      ),
      child: SizedBox(
        height: specialHeight ?? 50,
        width: width,
        child: TextFormField(
          maxLength: maxLength,
          keyboardType: keyboardType,
          enabled: enabled,
          focusNode: focusNode,
          minLines: minLines ?? 1,
          maxLines: maxLines ?? 1,
          cursorColor: black,
          cursorHeight: 20,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 13),
            hintText: hintText,
            counterText: '',
            hintStyle: const TextStyle(
              color: grey, // Set hint text color
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  final bool? enabled;
  final double? borderRadius;
  final int? minLines;
  final int? maxLines;
  final Color? borderColor;
  final Color? color;
  final double? width;
  final double? specialHeight;
  final EdgeInsetsGeometry? padding;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final VoidCallback onTap;
  final String title;

  const DatePicker({
    super.key,
    this.enabled,
    this.borderRadius,
    this.minLines,
    this.maxLines,
    this.borderColor,
    this.color,
    this.width,
    this.specialHeight,
    this.padding,
    required this.hintText,
    required this.controller,
    this.focusNode,
    required this.onTap,
    required this.title,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.title,
          size: h2,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            border: Border.all(
              color: widget.borderColor ?? grey,
              width: 1,
            ),
          ),
          child: SizedBox(
            height: widget.specialHeight ?? 50,
            width: widget.width,
            child: TextFormField(
              readOnly: true,
              focusNode: widget.focusNode,
              minLines: widget.minLines ?? 1,
              maxLines: widget.maxLines ?? 1,
              controller: widget.controller,
              onTap: widget.onTap,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                hintText: widget.hintText,
                counterText: '',
                hintStyle: const TextStyle(
                  color: grey,
                ),
                suffixIcon: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.calendarDays,
                      color: primary,
                      size: 16,
                    ),
                  ],
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FormDropDown extends StatelessWidget {
  final String title;
  final double size;
  final FontWeight weight;
  final double? fontSize;
  final Color? dropColor;
  final Object? value;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final List<DropdownMenuItem<Object>>? items;
  final void Function(Object?)? onChanged;
  final Widget? Icon; 
  final String? hint;
  final double dropdownHeight; 

  const FormDropDown({
    super.key,
    required this.fontSize,
    required this.onChanged,
    required this.value,
    required this.selectedItemBuilder,
    required this.items,
    required this.dropColor,
    this.Icon,
    this.hint,
    required this.title,
    required this.size,
    required this.weight,
    this.dropdownHeight = 200, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          size: h2,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: acrossLines, width: 1),
          ),
          child: DropdownButtonFormField(
            hint: const Text("Select one from the list"),
            borderRadius: BorderRadius.circular(8),
            focusColor: Colors.transparent,
            icon: Icon,
            value: value,
            elevation: 0,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
            dropdownColor: dropColor,
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(horizontal: 13),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            selectedItemBuilder: selectedItemBuilder,
            items: items,
            onChanged: onChanged,
            menuMaxHeight: dropdownHeight, // Set max height for dropdown
          ),
        ),
      ],
    );
  }
}
