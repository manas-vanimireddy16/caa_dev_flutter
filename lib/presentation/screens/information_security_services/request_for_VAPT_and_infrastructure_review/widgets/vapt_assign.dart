part of '../view.dart';

class VaptAssignDialogWidget extends ConsumerStatefulWidget {
  final int approverId;
  final Service service;
  final SubService subService;

  const VaptAssignDialogWidget({
    super.key,
    required this.approverId,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<VaptAssignDialogWidget> createState() =>
      _VaptAssignDialogWidgetState();
}

class _VaptAssignDialogWidgetState
    extends ConsumerState<VaptAssignDialogWidget> {
  DepartmentModel? selectedDepartment;
  SectionModel? selectedSection;

  late _VSControllerParams params;

  @override
  void initState() {
    super.initState();

    params = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    /// Load departments initially
    Future.microtask(() {
      ref.read(_vsProvider(params).notifier).fetchDepartments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(params));
    final controller = ref.read(_vsProvider(params).notifier);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// ================= DEPARTMENT =================
          DropdownSearch<DepartmentModel>(
            items: (filter, _) => state.departments,

            itemAsString: (d) => d.departmentName ?? "Unknown",

            compareFn: (a, b) => a.id == b.id, // ✅ FIX

            selectedItem: selectedDepartment,

            popupProps: const PopupProps.menu(showSearchBox: true),

            decoratorProps: const DropDownDecoratorProps(
              decoration: InputDecoration(
                labelText: "Department",
                border: OutlineInputBorder(),
              ),
            ),

            onSelected: (department) {
              if (department == null) return;

              setState(() {
                selectedDepartment = department;
                selectedSection = null; // reset section
              });

              controller.fetchSections(department.id.toString());
            },
          ),

          const SizedBox(height: 16),

          /// ================= SECTION =================
          DropdownSearch<SectionModel>(
            items: (filter, _) => state.sections,

            itemAsString: (s) => s.sectionName ?? "Unknown",

            compareFn: (a, b) => a.id == b.id, // ✅ FIX

            selectedItem: selectedSection,

            popupProps: const PopupProps.menu(showSearchBox: true),

            decoratorProps: const DropDownDecoratorProps(
              decoration: InputDecoration(
                labelText: "Section",
                border: OutlineInputBorder(),
              ),
            ),

            enabled: selectedDepartment != null,

            onSelected: (section) {
              if (section == null) return;

              setState(() {
                selectedSection = section;
              });
            },
          ),

          const SizedBox(height: 24),

          /// ================= BUTTON =================
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedSection == null
                  ? null
                  : () async {
                      await controller.assignEngineer(
                        approverId: widget.approverId,
                        departmentId: selectedDepartment?.id ?? 0,
                        sectionId: selectedSection?.id ?? 0,
                      );

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
              child: const Text("Assign"),
            ),
          ),
        ],
      ),
    );
  }
}
