import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_colors.dart';
import 'package:habit_tracker/theming/app_theme.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.initialValue = '',
    this.hintText = '',
    this.showChevron = false,
    this.onSubmit,
  });
  final String initialValue;
  final String hintText;
  final bool showChevron;
  final ValueChanged<String>? onSubmit;

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  void _clearText() {
    _controller.clear();
    // * This empty call to setState forces a rebuild which will hide the chevron.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.of(context).secondary,
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              // * This empty call to setState forces a rebuild which may show/hide the chevron.
              controller: _controller,
              onChanged: (value) => setState(() {}),
              onSubmitted: (value) {
                FocusScope.of(context).unfocus();
                widget.onSubmit?.call(value);
              },
              cursorColor: AppTheme.of(context).settingsText,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppTheme.of(context).settingsText,
                  ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppTheme.of(context).settingsText.withOpacity(0.4),
                    ),
                suffixIcon: _controller.text.trim().isNotEmpty
                    ? IconButton(
                        onPressed: _clearText,
                        icon: Icon(
                          Icons.cancel,
                          color: AppTheme.of(context).settingsText,
                        ),
                      )
                    : null,
              ),
            ),
          ),
          if (_controller.text.trim().isNotEmpty && widget.showChevron)
            Container(
              padding: const EdgeInsets.only(left: 4, right: 4),
              color: AppTheme.of(context).settingsListIconBackground,
              child: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  widget.onSubmit?.call(_controller.text);
                },
                icon: const Icon(
                  Icons.chevron_right,
                  color: AppColors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
