import 'package:flutter/material.dart';

import '../config/search_config.dart';

class DynamicField extends StatelessWidget {
  final FieldConfig config;
  final TextEditingController controller;

  const DynamicField({
    super.key,
    required this.config,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (config.type == FieldType.text) {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: config.label,
          hintText: config.placeholder,
        ),
      );
    }

    if (config.type == FieldType.date) {
      return TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: config.label,
          hintText: config.placeholder,
        ),
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );

          if (pickedDate != null) {
            controller.text =
                '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
          }
        },
      );
    }
    return const SizedBox.shrink();
  }
}
