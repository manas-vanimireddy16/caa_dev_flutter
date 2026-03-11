import 'package:code_setup/presentation/models/selection_dialog_model.dart';

class SelectionDialogConfig {
  final String title;
  final List<SelectionDialogItem> items;
  final bool isLoading;
  final Future<void> Function(SelectionDialogItem item) onItemSelected;

  const SelectionDialogConfig({
    required this.title,
    required this.items,
    required this.isLoading,
    required this.onItemSelected,
  });
}
