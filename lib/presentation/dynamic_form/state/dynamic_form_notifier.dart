// import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
// import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
// import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
// import 'package:code_setup/presentation/models/file_upload_model.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class DynamicFormNotifier extends StateNotifier<DynamicFormState> {
//   DynamicFormNotifier()
//     : super(const DynamicFormState(currentStep: 0, values: {}, errors: {})) {
//     print('🔥 DynamicFormNotifier CREATED');
//   }

//   /// ------------------------------------------------
//   /// ✅ CALL THIS ONCE WHEN FORM LOADS
//   /// ------------------------------------------------
//   // void initialize(
//   //   List<List<DynamicField>> steps, {
//   //   Map<String, dynamic>? apiValues,
//   // }) {
//   //   final allFields = steps.expand((e) => e);
//   //   final initialValues = <String, dynamic>{};

//   //   for (final field in allFields) {
//   //     initialValues[field.name] =
//   //         apiValues?[field.name] ?? field.initialValue ?? _defaultValue(field);
//   //   }

//   //   /// 🔥 BUSINESS DEFAULT (ONLY IF NOT PROVIDED BY API)
//   //   initialValues.putIfAbsent('missionSponsoredBy', () => 'CAA');
//   //   initialValues.putIfAbsent('sponsoredCompanyName', () => 'CAA');

//   //   state = state.copyWith(values: initialValues);
//   // }
//   void initialize(
//     List<List<DynamicField>> steps, {
//     Map<String, dynamic>? apiValues,
//   }) {
//     final allFields = steps.expand((e) => e);

//     final initialValues = <String, dynamic>{};

//     for (final field in allFields) {
//       apiValues?[field.name] = field;

//       /// ⭐ VERY IMPORTANT

//       initialValues[field.name] =
//           apiValues?[field.name] ?? field.initialValue ?? _defaultValue(field);
//     }

//     state = state.copyWith(values: initialValues);
//   }

//   /// ------------------------------------------------
//   /// ✅ UPDATE VALUE HANDLER
//   /// ------------------------------------------------
//   // void updateValue(String key, dynamic value) {
//   //   final values = Map<String, dynamic>.from(state.values);
//   //   values[key] = value;

//   //   if (key == 'remainingLeaveBalance' || key == 'basicSalaryPerDay') {
//   //     final leaveBalance =
//   //         double.tryParse(values['remainingLeaveBalance']?.toString() ?? '0') ??
//   //         0;

//   //     final basicSalary =
//   //         double.tryParse(values['basicSalaryPerDay']?.toString() ?? '0') ?? 0;

//   //     final total = leaveBalance * basicSalary;

//   //     values['totalSalaryDue'] = total > 0 ? total.toStringAsFixed(2) : '0';
//   //   }

//   //   /// -----------------------------
//   //   /// ✅ MISSION DAYS AUTO-CALC
//   //   /// -----------------------------
//   //   if (key == 'missionStartDate' || key == 'missionEndDate') {
//   //     DateTime? start;
//   //     DateTime? end;

//   //     final rawStart = values['missionStartDate'];
//   //     final rawEnd = values['missionEndDate'];

//   //     if (rawStart is DateTime) {
//   //       start = rawStart;
//   //     } else if (rawStart is String) {
//   //       start = DateTime.tryParse(rawStart);
//   //     }

//   //     if (rawEnd is DateTime) {
//   //       end = rawEnd;
//   //     } else if (rawEnd is String) {
//   //       end = DateTime.tryParse(rawEnd);
//   //     }

//   //     if (start != null && end != null) {
//   //       final diff = end.difference(start).inDays;
//   //       if (diff >= 0) {
//   //         values['missionDays'] = (diff + 1).toString();
//   //       } else {
//   //         values.remove('missionDays');
//   //       }
//   //     } else {
//   //       values.remove('missionDays');
//   //     }
//   //   }

//   //   /// -----------------------------
//   //   /// 🔥 MISSION SPONSORED BY RULE
//   //   /// -----------------------------
//   //   if (key == 'missionSponsoredBy') {
//   //     if (value == 'CAA') {
//   //       values['sponsoredCompanyName'] = 'CAA';
//   //     } else {
//   //       values.remove('sponsoredCompanyName');
//   //     }
//   //   }

//   //   state = state.copyWith(values: values);
//   // }
//   void updateValue(String key, dynamic value) {
//     final values = Map<String, dynamic>.from(state.values);
//     values[key] = value;

//     /// -----------------------------
//     /// SALARY AUTO CALC
//     /// -----------------------------
//     if (key == 'remainingLeaveBalance' || key == 'basicSalaryPerDay') {
//       final leaveBalance =
//           double.tryParse(values['remainingLeaveBalance']?.toString() ?? '0') ??
//           0;

//       final basicSalary =
//           double.tryParse(values['basicSalaryPerDay']?.toString() ?? '0') ?? 0;

//       final total = leaveBalance * basicSalary;

//       values['totalSalaryDue'] = total > 0 ? total.toStringAsFixed(2) : '0';
//     }

//     /// -----------------------------
//     /// MISSION DAYS AUTO CALC
//     /// -----------------------------
//     if (key == 'missionStartDate' || key == 'missionEndDate') {
//       DateTime? start;
//       DateTime? end;

//       final rawStart = values['missionStartDate'];
//       final rawEnd = values['missionEndDate'];

//       if (rawStart is DateTime) {
//         start = rawStart;
//       } else if (rawStart is String) {
//         start = DateTime.tryParse(rawStart);
//       }

//       if (rawEnd is DateTime) {
//         end = rawEnd;
//       } else if (rawEnd is String) {
//         end = DateTime.tryParse(rawEnd);
//       }

//       if (start != null && end != null) {
//         final diff = end.difference(start).inDays;
//         if (diff >= 0) {
//           values['missionDays'] = (diff + 1).toString();
//         } else {
//           values.remove('missionDays');
//         }
//       } else {
//         values.remove('missionDays');
//       }
//     }

//     /// -----------------------------
//     /// MISSION SPONSORED RULE
//     /// -----------------------------
//     if (key == 'missionSponsoredBy') {
//       if (value == 'CAA') {
//         values['sponsoredCompanyName'] = 'CAA';
//       } else {
//         values.remove('sponsoredCompanyName');
//       }
//     }

//     /// ⭐ UPDATE STATE FIRST
//     state = state.copyWith(values: values);

//     /// ⭐ VERY IMPORTANT → TRIGGER FIELD onChanged
//     final field = value[key];

//     if (field?.onChanged != null) {
//       /// delay ensures UI rebuild + state sync
//       Future.microtask(() {
//         field!.onChanged!(value);
//       });
//     }
//   }

//   /// ------------------------------------------------
//   /// ✅ FILE UPLOAD HELPERS
//   /// ------------------------------------------------
//   void onUploadFileSuccess(String fieldName, FileUploadItem file) {
//     final current = List<FileUploadItem>.from(state.values[fieldName] ?? []);
//     current.add(file);

//     state = state.copyWith(values: {...state.values, fieldName: current});
//   }

//   void onRemoveFile(String fieldName, int index) {
//     final current = List<FileUploadItem>.from(state.values[fieldName] ?? []);
//     if (index < 0 || index >= current.length) return;

//     current.removeAt(index);

//     state = state.copyWith(values: {...state.values, fieldName: current});
//   }

//   /// ------------------------------------------------
//   /// ✅ VALIDATION
//   /// ------------------------------------------------
//   bool validateStep(List<DynamicField> fields) {
//     final errors = <String, String?>{};

//     for (final field in fields) {
//       final value = state.values[field.name];

//       if (field.type == FieldType.file && field.required) {
//         final files = value as List<FileUploadItem>?;

//         if (files == null || files.isEmpty) {
//           errors[field.name] = '${field.label} is required';
//         }
//         continue;
//       }

//       if (field.required && (value == null || value.toString().isEmpty)) {
//         errors[field.name] = '${field.label} is required';
//       }
//     }

//     state = state.copyWith(errors: errors);
//     return errors.isEmpty;
//   }

//   /// ------------------------------------------------
//   /// ✅ STEPS
//   /// ------------------------------------------------
//   void nextStep() {
//     state = state.copyWith(currentStep: state.currentStep + 1);
//   }

//   void previousStep() {
//     state = state.copyWith(currentStep: state.currentStep - 1);
//   }

//   void autoPopulate(Map<String, dynamic> newValues) {
//     state = state.copyWith(values: {...state.values, ...newValues});
//   }

//   Map<String, dynamic> submit() => state.values;

//   /// ------------------------------------------------
//   /// ✅ DEFAULT VALUES
//   /// ------------------------------------------------
//   static dynamic _defaultValue(DynamicField field) {
//     switch (field.type) {
//       case FieldType.checkbox:
//       case FieldType.multiselect:
//         return <dynamic>[];
//       case FieldType.toggle:
//         return false;
//       default:
//         return '';
//     }
//   }
// }

import 'package:code_setup/presentation/dynamic_form/models/dynamic_field.dart';
import 'package:code_setup/presentation/dynamic_form/models/field_type.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicFormNotifier extends StateNotifier<DynamicFormState> {
  final Ref ref;

  /// ⭐ store all fields for triggering onChanged
  final Map<String, DynamicField> _fieldsMap = {};

  DynamicFormNotifier(this.ref)
    : super(const DynamicFormState(currentStep: 0, values: {}, errors: {})) {
    print('🔥 DynamicFormNotifier CREATED');
  }

  /// ------------------------------------------------
  /// ✅ INITIALIZE FORM
  /// ------------------------------------------------
  void initialize(
    List<List<DynamicField>> steps, {
    Map<String, dynamic>? apiValues,
  }) {
    final allFields = steps.expand((e) => e);
    final initialValues = <String, dynamic>{};

    for (final field in allFields) {
      /// ⭐ VERY IMPORTANT
      _fieldsMap[field.name] = field;

      initialValues[field.name] =
          apiValues?[field.name] ?? field.initialValue ?? _defaultValue(field);
    }

    state = state.copyWith(values: initialValues);
  }

  /// ------------------------------------------------
  /// ✅ UPDATE VALUE HANDLER
  /// ------------------------------------------------
  void updateValue(String key, dynamic value) {
    final values = Map<String, dynamic>.from(state.values);
    values[key] = value;

    /// -----------------------------
    /// SALARY AUTO CALC
    /// -----------------------------
    if (key == 'remainingLeaveBalance' || key == 'basicSalaryPerDay') {
      final leaveBalance =
          double.tryParse(values['remainingLeaveBalance']?.toString() ?? '0') ??
          0;

      final basicSalary =
          double.tryParse(values['basicSalaryPerDay']?.toString() ?? '0') ?? 0;

      final total = leaveBalance * basicSalary;

      values['totalSalaryDue'] = total > 0 ? total.toStringAsFixed(2) : '0';
    }

    /// -----------------------------
    /// MISSION DAYS AUTO CALC
    /// -----------------------------
    if (key == 'missionStartDate' || key == 'missionEndDate') {
      DateTime? start;
      DateTime? end;

      final rawStart = values['missionStartDate'];
      final rawEnd = values['missionEndDate'];

      if (rawStart is DateTime) {
        start = rawStart;
      } else if (rawStart is String) {
        start = DateTime.tryParse(rawStart);
      }

      if (rawEnd is DateTime) {
        end = rawEnd;
      } else if (rawEnd is String) {
        end = DateTime.tryParse(rawEnd);
      }

      if (start != null && end != null) {
        final diff = end.difference(start).inDays;
        if (diff >= 0) {
          values['missionDays'] = (diff + 1).toString();
        } else {
          values.remove('missionDays');
        }
      } else {
        values.remove('missionDays');
      }
    }

    /// -----------------------------
    /// MISSION SPONSORED RULE
    /// -----------------------------
    if (key == 'missionSponsoredBy') {
      if (value == 'CAA') {
        values['sponsoredCompanyName'] = 'CAA';
      } else {
        values.remove('sponsoredCompanyName');
      }
    }

    state = state.copyWith(values: values);
  }

  /// ------------------------------------------------
  /// FILE UPLOAD HELPERS
  /// ------------------------------------------------
  void onUploadFileSuccess(String fieldName, FileUploadItem file) {
    final current = List<FileUploadItem>.from(state.values[fieldName] ?? []);
    current.add(file);

    state = state.copyWith(values: {...state.values, fieldName: current});
  }

  void onRemoveFile(String fieldName, int index) {
    final current = List<FileUploadItem>.from(state.values[fieldName] ?? []);
    if (index < 0 || index >= current.length) return;

    current.removeAt(index);

    state = state.copyWith(values: {...state.values, fieldName: current});
  }

  /// ------------------------------------------------
  /// VALIDATION
  /// ------------------------------------------------
  // bool validateStep(List<DynamicField> fields) {
  //   final errors = <String, String?>{};

  //   for (final field in fields) {
  //     final value = state.values[field.name];

  //     if (field.type == FieldType.file && field.required) {
  //       final files = value as List<FileUploadItem>?;

  //       if (files == null || files.isEmpty) {
  //         errors[field.name] = '${field.label} is required';
  //       }

  //       continue;
  //     }

  //     if (field.required && (value == null || value.toString().isEmpty)) {
  //       errors[field.name] = '${field.label} is required';
  //     }
  //   }

  //   state = state.copyWith(errors: errors);
  //   return errors.isEmpty;
  // }
  bool validateStep(List<DynamicField> fields) {
    final errors = <String, String?>{};

    for (final field in fields) {
      final value = state.values[field.name];

      /// FILE VALIDATION
      if (field.type == FieldType.file && field.required) {
        final files = value as List<FileUploadItem>?;

        if (files == null || files.isEmpty) {
          errors[field.name] = '${field.label} is required';
        }
        continue;
      }

      /// UNIVERSAL REQUIRED VALIDATION
      if (field.required) {
        bool isEmpty = false;

        if (value == null) {
          isEmpty = true;
        } else if (value is String && value.trim().isEmpty) {
          isEmpty = true;
        } else if (value is List && value.isEmpty) {
          isEmpty = true;
        }

        if (isEmpty) {
          errors[field.name] = '${field.label} is required';
        }
      }
    }

    state = state.copyWith(errors: errors);
    return errors.isEmpty;
  }

  /// ------------------------------------------------
  /// STEPS
  /// ------------------------------------------------
  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void previousStep() {
    state = state.copyWith(currentStep: state.currentStep - 1);
  }

  void autoPopulate(Map<String, dynamic> newValues) {
    state = state.copyWith(values: {...state.values, ...newValues});
  }

  Map<String, dynamic> submit() => state.values;

  /// ------------------------------------------------
  /// DEFAULT VALUES
  /// ------------------------------------------------
  static dynamic _defaultValue(DynamicField field) {
    switch (field.type) {
      case FieldType.checkbox:
      case FieldType.multiselect:
        return <dynamic>[];
      case FieldType.toggle:
        return false;
      default:
        return '';
    }
  }
}
