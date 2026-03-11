import 'package:code_setup/presentation/core_widgets/bottom_sheet_drager.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewRequestForm extends ConsumerStatefulWidget {
  const NewRequestForm({Key? key}) : super(key: key);

  @override
  ConsumerState<NewRequestForm> createState() => _NewRequestFormState();
}

class _NewRequestFormState extends ConsumerState<NewRequestForm> {
  String? selectedCategory;
  String? selectedSubCategory;
  String? preferredDate;
  String? preferredTime;

  @override
  Widget build(BuildContext context) {
    final categories = [
      KDropdownItem(value: "IT", child: const Text("IT")),
      KDropdownItem(value: "HR", child: const Text("HR")),
      KDropdownItem(value: "Finance", child: const Text("Finance")),
    ];

    final subCategories = [
      KDropdownItem(value: "Sub 1", child: const Text("Sub 1")),
      KDropdownItem(value: "Sub 2", child: const Text("Sub 2")),
      KDropdownItem(value: "Sub 3", child: const Text("Sub 3")),
    ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  const KBottomSheetDrager(),
            const SizedBox(height: 16),
            Text("New Request", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              "Provide details about your New Request",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),

            KDropdownField<String>(
              fieldHeadingText: "Category *",
              items: categories,
              value: selectedCategory,
              hintText: "Select Category",
              onChanged: (val) => setState(() => selectedCategory = val),
            ),
            const SizedBox(height: 16),

            KDropdownField<String>(
              fieldHeadingText: "Sub Category *",
              items: subCategories,
              value: selectedSubCategory,
              hintText: "Select Sub Category",
              onChanged: (val) => setState(() => selectedSubCategory = val),
            ),
            const SizedBox(height: 16),

            const KTextField(
              fieldHeadingText: "Request Title",
              hintText: "Enter request title",
            ),
            const SizedBox(height: 16),

            KTextField(
              fieldHeadingText: "Preferred Date *",
              hintText: preferredDate ?? "DD/MM/YYYY",
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() {
                    preferredDate = "${date.day}/${date.month}/${date.year}";
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            KTextField(
              fieldHeadingText: "Preferred Time *",
              hintText: preferredTime ?? "HH:MM",
              readOnly: true,
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() {
                    preferredTime = time.format(context);
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            const KTextField(
              fieldHeadingText: "Description (Optional)",
              hintText: "Add your comments",
              maxLines: 3,
              isMaxLines: true,
            ),
            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
