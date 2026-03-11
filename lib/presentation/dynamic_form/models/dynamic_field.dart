import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef VisibilityCondition = bool Function(Map<String, dynamic> values);
typedef CustomFieldBuilder =
    Widget Function(BuildContext context, WidgetRef ref);

class DynamicField {
  final String name;
  final String label;
  final FieldType type;
  final bool required;
  final String? placeholder;
  final bool disabled;
  final List<dynamic>? options;
  final dynamic initialValue;
  final VisibilityCondition? visibleWhen;
  final CustomFieldBuilder? builder;
  final Function(dynamic value, WidgetRef ref)? onChanged;
  final int? maxFiles; // for file upload field
  final int? maxFileSizeInMB; // for file upload field
  final List<String>? allowedExtensions;

  const DynamicField({
    required this.name,
    required this.label,
    required this.type,
    this.required = false,
    this.placeholder,
    this.disabled = false,
    this.options,
    this.initialValue,
    this.visibleWhen,
    this.builder,
    this.onChanged,
    this.maxFiles,
    this.maxFileSizeInMB,
    this.allowedExtensions,
  });
}

class DropdownOption<T> {
  final T value; // actual stored value (id / object / enum)
  final String label; // what user sees

  const DropdownOption({required this.value, required this.label});
}
