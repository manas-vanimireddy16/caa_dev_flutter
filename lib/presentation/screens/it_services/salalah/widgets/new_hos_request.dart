part of '../view.dart';

final _hosFormKey = GlobalKey<FormState>(); // ⬅ ADD THIS

@RoutePage()
class SalalahHOSNewRequestScreen extends ConsumerStatefulWidget {
  final Service service;
  final SubService subService;
  const SalalahHOSNewRequestScreen({super.key, required this.service, required this.subService});

  @override
  ConsumerState<SalalahHOSNewRequestScreen> createState() =>
      _SalalahHOSNewRequestScreenState();
}

class _SalalahHOSNewRequestScreenState extends ConsumerState<SalalahHOSNewRequestScreen> {
  @override
    late _VSControllerParams _providerArgs;

  void initState() {
    super.initState();
    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(_providerArgs));
    final controller = ref.read(_vsProvider(_providerArgs).notifier);
    final userInfo = ref.read(userInfoProvider);

    return Scaffold(
      appBar: KAppBar(title: const Text('New Ticket')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _hosFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ----------------------- Request For -----------------------
                Row(
                  children: ['Self', 'Behalf of'].map((role) {
                    return Expanded(
                      child: RadioListTile(
                        value: role,
                        groupValue: state.selectedRequestFor,
                        title: Text(role),
                        onChanged: (value) =>
                            controller.onselectedRequestFor(value.toString()),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                /// ----------------------- Person Name -----------------------
                state.selectedRequestFor.toLowerCase() == "self"
                    ? KTextField(
                        fieldHeadingText: "Person Name *",
                        hintText: userInfo?.data?.employeeName,
                        readOnly: true,
                      )
                    : KTextField(
                        fieldHeadingText: "Person Name *",
                        controller: controller.personNameController,
                        hintText: "Enter Name",
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Person Name is required";
                          }
                          return null;
                        },
                      ),

                /// ----------------------- Contact Number -----------------------
                state.selectedRequestFor.toLowerCase() == "self"
                    ? KTextField(
                        fieldHeadingText: "Contact Number *",
                        hintText: userInfo?.data?.mobile,
                        readOnly: true,
                      )
                    : KTextField(
                        fieldHeadingText: "Contact Number *",
                        controller: controller.contactNumberController,
                        keyboardType: TextInputType.phone,
                        hintText: "Enter Contact",
                        onChanged: controller.validatePhone,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Contact Number is required";
                          }
                          if (!RegExp(r'^[0-9]{8}$').hasMatch(v)) {
                            return "Phone number must be exactly 8 digits";
                          }
                          return null;
                        },
                      ),

                /// ----------------------- Department -----------------------
                state.selectedRequestFor.toLowerCase() == "self"
                    ? KTextField(
                        fieldHeadingText: "Department *",
                        hintText:
                            userInfo?.data?.department?.departmentName ?? '',
                        readOnly: true,
                      )
                    : KDropdownField<String>(
                        fieldHeading: const Text('Department *'),
                        items: state.departments
                            .map(
                              (d) => KDropdownItem(
                                value: d.id.toString(),
                                child: SizedBox(
                                  width: 150.toAutoScaledWidth,
                                  child: Text(d.departmentName ?? ''),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          final id = int.tryParse(value ?? '') ?? 0;
                          if (id != 0) controller.fetchSections(id);
                          controller.updateDepartmentId(id);
                        },
                        // validator: (value) {
                        //   if (state.selectedRequestFor == "Self") return null;
                        //   if (value == null || value.isEmpty) {
                        //     return "Department is required";
                        //   }
                        //   return null;
                        // },
                      ),

                /// ----------------------- Section -----------------------
                state.selectedRequestFor.toLowerCase() == "self"
                    ? KTextField(
                        fieldHeadingText: "Section *",
                        hintText: userInfo?.data?.section?.sectionName ?? '',
                        readOnly: true,
                      )
                    : KDropdownField<String>(
                        fieldHeading: const Text('Section *'),
                        value: state.sectionId == 0
                            ? null
                            : state.sectionId.toString(),
                        items: state.sections
                            .map(
                              (s) => KDropdownItem(
                                value: s.id.toString(),
                                child: SizedBox(
                                  width: 150.toAutoScaledWidth,
                                  child: Text(s.sectionName ?? ''),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          controller.updateSectionId(int.parse(value));
                        },
                        // validator: (value) {
                        //   if (state.selectedRequestFor == "Self") return null;
                        //   if (value == null || value.isEmpty) {
                        //     return "Section is required";
                        //   }
                        //   return null;
                        // },
                      ),

                /// ----------------------- Service Type -----------------------
                KDropdownField<String>(
                  fieldHeading: const Text('Service Type *'),
                  items: state.serviceDropDown
                      .map(
                        (s) => KDropdownItem(
                          value: s.id.toString(),
                          child: SizedBox(
                            width: 150.toAutoScaledWidth,
                            child: Text(s.name ?? ''),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.updateServiceTypeId(int.parse(value!));
                  },
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Service Type is required";
                  //   }
                  //   return null;
                  // },
                ),

                /// ----------------------- Problem -----------------------
                KTextField(
                  fieldHeadingText: "Problem *",
                  controller: controller.problemController,
                  hintText: "Enter Problem",
                  maxLines: 2,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Problem is required";
                    }
                    return null;
                  },
                ),

                /// ----------------------- Description -----------------------
                KTextField(
                  fieldHeadingText: "Description (Optional)",
                  controller: controller.descriptionController,
                  maxLines: 3,
                  hintText: "Describe the issue...",
                ),

                /// ----------------------- Email -----------------------
                if (state.selectedRequestFor == "Behalf of")
                  KTextField(
                    fieldHeadingText: "Email *",
                    controller: controller.emailController,
                    hintText: "example@gmail.com",
                    onChanged: controller.validateEmail,
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Email is required";
                      if (!RegExp(
                        r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(v)) {
                        return "Invalid email format";
                      }
                      return null;
                    },
                  ),

                /// ----------------------- IT Technician --------------------
                KDropdownField<String>(
                  fieldHeadingText: "IT Technician *",
                  items: state.itTechnician
                      .map(
                        (tech) => KDropdownItem(
                          value: tech.userId.toString(),
                          child: SizedBox(
                            width: 150.toAutoScaledWidth,
                            child: Text(tech.employeeName ?? ''),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.updateTechnicianId(int.parse(value!));
                  },
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Technician is required";
                  //   }
                  //   return null;
                  // },
                ),

                /// ----------------------- Extension Number -----------------------
                KTextField(
                  fieldHeadingText: "Extension Number *",
                  controller: controller.extensionNumberController,
                  keyboardType: TextInputType.number,
                  hintText: "1234",
                  onChanged: controller.validateExtension,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Extension required";
                    if (v.length > 5) return "Max 5 digits allowed";
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// ----------------------- File Upload -----------------------
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        onPressed: controller.pickFile,
                        icon: const Icon(Icons.upload_file),
                        label: const Text("Upload Files"),
                      ),
                      const SizedBox(height: 8),
                      ...state.attachments.map((file) {
                        return ListTile(
                          title: Text(file["file_name"] ?? ''),
                          subtitle: Text(file["file_type"] ?? ''),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => controller.removeFile(file),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                /// ----------------------- Submit Button -----------------------
                ElevatedButton.icon(
                  onPressed: () {
                    if (_hosFormKey.currentState!.validate() == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Fix errors before submitting"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    controller.submitHOSRequest();
                  },
                  icon: state.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Icon(Icons.send),
                  label: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
