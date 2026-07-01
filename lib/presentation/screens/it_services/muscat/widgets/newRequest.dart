part of '../view.dart';

@RoutePage()
class MuscatEmployeeNewRequestScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  final int serviceId;
  final int subServiceId;
  const MuscatEmployeeNewRequestScreen({
    super.key,
    required this.service,
    required this.subService,
    required this.serviceId,
    required this.subServiceId,
  });

  @override
  ConsumerState<MuscatEmployeeNewRequestScreen> createState() =>
      _MuscatEmployeeNewRequestScreenState();
}

class _MuscatEmployeeNewRequestScreenState
    extends ConsumerState<MuscatEmployeeNewRequestScreen> {
  late _VSControllerParams _providerArgs;
  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );

    Future.microtask(() {
      final userInfo = KAppX.globalProvider.read(userInfoProvider);

      ref.read(_vsProvider(_providerArgs).notifier).fetchDepartments();
      ref.read(_vsProvider(_providerArgs).notifier).fetchServices();
      // ref.read(_vsProvider(_providerArgs).notifier).fetchitTechnician();

      final deptId = int.tryParse(userInfo?.data?.department?.id ?? '') ?? 0;

      ref.read(_vsProvider(_providerArgs).notifier).fetchSections(deptId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final l10n = DashboardL10n.of(context);

    return KScaffold(
      backgroundColor: Colors.white,

      /// ✅ DynamicForm MUST be root-level in a screen
      body: ProviderScope(
        overrides: [
          dynamicFormProvider.overrideWith((ref) => DynamicFormNotifier(ref)),
        ],
        child: DynamicForm(
          title: 'New Request',
          stepTitles: const [''],
          steps: [controller.buildSalalahFields(l10n)],

          /// ⭐ VERY IMPORTANT
          // enableSubmitWhen: (values) {
          //   return state.hrTasks.isNotEmpty;
          // },
          onSubmit: (values) async {
            await controller.sumbitSalalahRequest(
              widget.serviceId,
              widget.subServiceId,
              values,
            );

            if (context.mounted) {
              context.router.pop();
            }
          },
        ),
      ),
    );
  }

  // void initState() {
  //   super.initState();
  //   _providerArgs = _VSControllerParams(
  //     service: widget.service,
  //     subService: widget.subService,
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   final state = ref.watch(_vsProvider(_providerArgs));
  //   final controller = ref.read(_vsProvider(_providerArgs).notifier);
  //   final user = ref.read(userProvider);
  //   final userInfo = ref.read(userInfoProvider);

  //   String? selectedServiceTypeId;

  //   return Scaffold(
  //     appBar: KAppBar(title: const Text('New Ticket')),
  //     body: SafeArea(
  //       child: SingleChildScrollView(
  //         padding: const EdgeInsets.all(16),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             /// Request For
  //             Row(
  //               children: ['Self', 'Behalf of'].map((role) {
  //                 return Expanded(
  //                   child: RadioListTile(
  //                     value: role,
  //                     groupValue: state.selectedRequestFor,
  //                     title: Text(role),
  //                     onChanged: (value) =>
  //                         controller.onselectedRequestFor(value.toString()),
  //                   ),
  //                 );
  //               }).toList(),
  //             ),
  //             const SizedBox(height: 16),

  //             /// Form Fields
  //             state.selectedRequestFor.toLowerCase() == 'self'
  //                 ? KTextField(
  //                     fieldHeadingText: 'Person Name *',
  //                     // controller: controller.personNameController,
  //                     hintText: userInfo?.data?.employeeName,
  //                     readOnly: true,
  //                   )
  //                 : KTextField(
  //                     fieldHeadingText: 'Person Name *',
  //                     controller: controller.personNameController,
  //                     hintText: 'Enter Name',
  //                     readOnly: false,
  //                   ),

  //             state.selectedRequestFor.toLowerCase() == 'self'
  //                 ? KTextField(
  //                     fieldHeadingText: 'Contact Number *',
  //                     // controller: controller.contactNumberController,
  //                     hintText: userInfo?.data?.mobile,
  //                     keyboardType: TextInputType.phone,
  //                     readOnly: true,
  //                   )
  //                 : KTextField(
  //                     fieldHeadingText: 'Contact Number *',
  //                     controller: controller.contactNumberController,
  //                     hintText: 'xxxxxxxxxx',
  //                     keyboardType: TextInputType.phone,
  //                   ),

  //             state.selectedRequestFor.toLowerCase() == 'self'
  //                 ? KTextField(
  //                     fieldHeadingText: 'Department *',
  //                     // controller: controller.departmentController,
  //                     hintText: userInfo?.data?.department?.departmentName,
  //                     readOnly: true,
  //                   )
  //                 : KTextField(
  //                     fieldHeadingText: 'Department *',
  //                     controller: controller.departmentController,
  //                     hintText: "IT",
  //                   ),

  //             state.selectedRequestFor.toLowerCase() == 'self'
  //                 ? KTextField(
  //                     fieldHeadingText: 'Section *',
  //                     // controller: controller.sectionController,
  //                     hintText: userInfo?.data?.section?.sectionName,
  //                   )
  //                 : KTextField(
  //                     fieldHeadingText: 'Section *',
  //                     controller: controller.sectionController,
  //                     hintText: "Hardware",
  //                   ),
  //             KDropdownField<String>(
  //               fieldHeading: const Text('Service Type *'),
  //               items: state.serviceDropDown
  //                   .map(
  //                     (service) => KDropdownItem(
  //                       value: service.id.toString(),
  //                       // use id for dropdown selection
  //                       child: SizedBox(
  //                         // maxLines: 3,
  //                         width: 150.toAutoScaledWidth,
  //                         child: Text(
  //                           service?.name ?? 'Select Service Type',
  //                           maxLines: 3,
  //                         ),
  //                       ),
  //                     ),
  //                   )
  //                   .toList(),
  //               onChanged: (value) {
  //                 final selectedId = int.tryParse(value ?? '0') ?? 0;

  //                 final selectedService = state.serviceDropDown.firstWhere(
  //                   (service) => service.id == selectedId,
  //                 );

  //                 print("Selected Service → ${selectedService.id}");

  //                 controller.updateServiceId(selectedService.service?.id ?? 0);
  //                 controller.updateServiceTypeId(selectedService.id ?? 0);
  //                 controller.updateSubServiceId(
  //                   selectedService.subService?.id ?? 0,
  //                 );
  //               },
  //             ),

  //             KTextField(
  //               fieldHeadingText: 'Problem *',
  //               controller: controller.problemController,
  //               hintText: "Enter Problem",
  //               maxLines: 2,
  //             ),
  //             KTextField(
  //               fieldHeadingText: 'Description',
  //               controller: controller.descriptionController,
  //               hintText: "Describe the issue...",
  //               maxLines: 3,
  //             ),
  //             if (state.selectedRequestFor == "Behalf of")
  //               KTextField(
  //                 fieldHeadingText: 'Email *',
  //                 controller: controller.emailController,
  //                 hintText: "example@gmail.com",
  //               ),
  //             KTextField(
  //               fieldHeadingText: 'Extension Number',
  //               controller: controller.extensionNumberController,
  //               hintText: "1234",
  //               keyboardType: TextInputType.number,
  //             ),

  //             const SizedBox(height: 16),

  //             /// File Upload
  //             Container(
  //               padding: const EdgeInsets.all(12),
  //               decoration: BoxDecoration(
  //                 border: Border.all(color: Colors.grey.shade300),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   ElevatedButton.icon(
  //                     onPressed: controller.pickFile,
  //                     icon: const Icon(Icons.upload_file),
  //                     label: const Text("Upload Files"),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   ...state.attachments.map((file) {
  //                     return ListTile(
  //                       title: Text(file["file_name"] ?? ''),
  //                       subtitle: Text(file["file_type"] ?? ''),
  //                       trailing: IconButton(
  //                         icon: const Icon(Icons.delete, color: Colors.red),
  //                         onPressed: () => controller.removeFile(file),
  //                       ),
  //                     );
  //                   }),
  //                 ],
  //               ),
  //             ),

  //             const SizedBox(height: 24),

  //             /// Submit
  //             ElevatedButton.icon(
  //               onPressed: () {
  //                 controller.submitRequest();
  //               },
  //               icon: state.isLoading
  //                   ? const CircularProgressIndicator(color: Colors.white)
  //                   : const Icon(Icons.send),
  //               label: const Text("Submit"),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
