import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reminder_app/app_themes.dart';

class InputField extends StatelessWidget {
  final TextEditingController textValueController;
  final String? valueKey;
  final String label;
  final Function? onValidate;
  final Function? onEditComplete;
  final String hint;
  final int? maxLine;
  final FocusNode node;
  final TextInputType? textInputType;
  final String? initialValue;
  final Widget? suffixIcon;
  final Function? onSuffixTap;
  InputField(
      {required this.textValueController,
      this.maxLine,
      this.textInputType,
      this.onSuffixTap,
      this.initialValue,
      this.suffixIcon,
      this.onEditComplete,
      this.onValidate,
      this.valueKey,
      required this.hint,
      required this.label,
      required this.node});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            '$label',
            style: AppThemes().labelStyle,
          ),
        ),
        TextFormField(
          style: TextStyle(fontSize: 12),
          maxLines: maxLine,
          readOnly: onSuffixTap == null ? false : true,
          controller: textValueController,
          initialValue: initialValue,
          cursorColor: Colors.green,
          focusNode: node,
          key: ValueKey(valueKey),
          validator: onValidate as String? Function(String?)?,
          textInputAction: TextInputAction.next,
          onEditingComplete: onEditComplete as void Function()?,
          keyboardType: textInputType,
          decoration: InputDecoration(
              filled: true,
              suffixIcon: InkWell(
                onTap: onSuffixTap as void Function()?,
                child: suffixIcon!,
              ),
              hintText: hint),
        ),
      ],
    );
  }
}

String getMessage(int apiTimestamp) {
  DateTime apiDateTime =
      DateTime.fromMillisecondsSinceEpoch(apiTimestamp * 1000);
  DateTime now = DateTime.now();

  if (now.isAfter(apiDateTime)) {
    // return 'Passed before';
    return '';
  } else {
    // return 'Starts in';
    return '';
  }
}

String formatTimeDifference(int apiTimestamp) {
  DateTime apiDateTime =
      DateTime.fromMillisecondsSinceEpoch(apiTimestamp * 1000);
  DateTime now = DateTime.now();
  Duration difference = now.difference(apiDateTime);

  int hours = difference.inHours;
  int day = difference.inDays;
  int minutes = difference.inMinutes.remainder(60);
  int seconds = difference.inSeconds.remainder(60);
  log("day is here ===>$day");
  String timeDifHMS = '${hours.abs()}h ${minutes.abs()}m ${seconds.abs()}s';
  String timeDifHM = '${hours.abs()}h ${minutes.abs()}m';
  String timeDifMS = '${minutes.abs()}m ${seconds.abs()}s';
  String timeDifDHMS =
      '${day}d ${hours.abs()}h ${minutes.abs()}m ${seconds.abs()}s';
  if (day.abs() != 1) {
    return timeDifDHMS;
  } else if (hours.abs() == 0) {
    return timeDifMS;
  } else {
    return timeDifHMS;
  }
}
