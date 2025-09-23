import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel(); // cancel previous timer
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

enum TextFieldStyle {
  material,
  cupertino,
}

class CustomSearchBar extends ConsumerStatefulWidget {
  final String? placeholder;
  final int debounceMilliseconds;
  final TextFieldStyle style;
  final void Function(WidgetRef ref, String query) onSearch;

  // Customizable visual properties
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;

  const CustomSearchBar({
    required this.onSearch,
    super.key,
    this.placeholder,
    this.debounceMilliseconds = 500,
    this.style = TextFieldStyle.material,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.textStyle,
    this.borderRadius,
  });

  @override
  ConsumerState<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  late final Debouncer _debouncer;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(milliseconds: widget.debounceMilliseconds);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debouncer.run(() => widget.onSearch(ref, value));
    setState(() {}); // Update clear button visibility
  }

  void _clearText() {
    _controller.clear();
    _onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(12);

    switch (widget.style) {
      case TextFieldStyle.cupertino:
        return CupertinoTextField(
          controller: _controller,
          placeholder: widget.placeholder ?? 'Search',
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          onChanged: _onChanged,
          clearButtonMode: OverlayVisibilityMode.editing,
          style:
              widget.textStyle ??
              TextStyle(color: widget.textColor ?? CupertinoColors.black),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Icon(
              CupertinoIcons.search,
              color: widget.iconColor ?? CupertinoColors.systemGrey,
            ),
          ),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? CupertinoColors.systemGrey6,
            borderRadius: borderRadius,
          ),
        );

      case TextFieldStyle.material:
        return TextField(
          controller: _controller,
          onChanged: _onChanged,
          style:
              widget.textStyle ??
              TextStyle(color: widget.textColor ?? Colors.black),
          decoration: InputDecoration(
            hintText: widget.placeholder ?? 'Search',
            prefixIcon: Icon(
              Icons.search,
              color: widget.iconColor ?? Colors.grey,
            ),
            suffixIcon: _controller.text.isEmpty
                ? null
                : GestureDetector(
                    onTap: _clearText,
                    child: Icon(
                      Icons.clear,
                      color: widget.iconColor ?? Colors.grey,
                    ),
                  ),
            filled: true,
            fillColor: widget.backgroundColor ?? Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide.none,
            ),
          ),
        );
    }
  }
}

class CustomTextField extends ConsumerStatefulWidget {
  final String? placeholder;
  final TextFieldStyle style;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;

  const CustomTextField({
    super.key,
    this.placeholder,
    this.style = TextFieldStyle.material,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.textStyle,
    this.borderRadius,
  });

  @override
  ConsumerState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  late final TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _validate(String value) {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(12);

    switch (widget.style) {
      case TextFieldStyle.cupertino:
        return Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoTextField(
                controller: _controller,
                placeholder: widget.placeholder ?? '',
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                style:
                    widget.textStyle ??
                    TextStyle(color: widget.textColor ?? CupertinoColors.black),
                prefix: widget.prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: widget.prefixIcon,
                      )
                    : null,
                suffix: widget.suffixIcon,
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? CupertinoColors.systemGrey6,
                  borderRadius: borderRadius,
                ),
                onChanged: _validate,
              ),
              if (_errorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4),
                  child: Text(
                    _errorText!,
                    style: const TextStyle(
                      color: CupertinoColors.systemRed,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        );

      case TextFieldStyle.material:
        return Material(
          child: TextField(
            controller: _controller,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            style:
                widget.textStyle ??
                TextStyle(color: widget.textColor ?? Colors.black),
            onChanged: _validate,
            decoration: InputDecoration(
              hintText: widget.placeholder ?? '',
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              filled: true,
              fillColor: widget.backgroundColor ?? Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
              errorText: _errorText,
            ),
          ),
        );
    }
  }
}
