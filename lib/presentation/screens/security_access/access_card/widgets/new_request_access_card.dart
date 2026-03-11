part of '../view.dart';

@RoutePage()
class AccessCardNewRequestScreen extends ConsumerStatefulWidget {
  // final List<KDropdownItem<String>> serviceTypeOptions;
  const AccessCardNewRequestScreen({
    super.key,
    //required this.serviceTypeOptions,
  });

  @override
  ConsumerState<AccessCardNewRequestScreen> createState() =>
      _AccessCardNewRequestScreenState();
}

class _AccessCardNewRequestScreenState
    extends ConsumerState<AccessCardNewRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider);
    final stateController = ref.read(_vsProvider.notifier);
    final userInfo = ref.read(userInfoProvider);

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return KScaffold(
      appBar: KAppBar(title: const Text('New Request for Access Card')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Provide details about your New Request",
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s14,
                  fontWeight: currentTheme.fontWeights.wBold,
                ),
              ),
              16.toVerticalSizedBox,

              CustomRadioGroup(
                label: 'Request for',
                options: ['Self', 'Behalf of'],
                view: ['Self', 'Behalf of'],
                selectedValue: state.selectedRequestFor,
                disabledOptions:
                    state.currentRoleName.toLowerCase() == "employee"
                    ? ['Behalf of']
                    : [],
                onChanged: (value) {
                  stateController.onSelectedRole(value);
                },
              ),

              16.toVerticalSizedBox,
              state.selectedRequestFor.toLowerCase() == "self"
                  ? KTextField(
                      fieldHeadingText: "Person Name *",
                      hintText: userInfo?.data?.employeeName,
                      readOnly: true,
                    )
                  : KTextField(
                      fieldHeadingText: "Person Name *",
                      controller: stateController.personNameController,
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
                      controller: stateController.contactNumberController,
                      keyboardType: TextInputType.phone,
                      hintText: "Enter Contact",
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
                        stateController.updateDepartmentId(id);
                      },
                    ),

              12.toVerticalSizedBox,

              KDropdownField<String>(
                fieldHeading: Text('Request Type *'),
                decoration: const InputDecoration(
                  labelText: "Select *",
                  border: OutlineInputBorder(),
                ),
                items: [
                  KDropdownItem(value: "New", child: Text("New")),
                  KDropdownItem(value: "Renewal", child: Text("Renewal")),
                ],
                onChanged: (value) {
                  stateController.onSelectedRequestType(value ?? '');
                },
              ),

              KTextField(
                fieldHeadingText: 'Email *',
                controller: stateController.emailController,
                hintText: "Enter Request Title ",
              ),
              12.toVerticalSizedBox,
              state.selectedRequestFor.toLowerCase() == 'self'
                  ? KDropdownField<String>(
                      fieldHeading: Text('Category *'),
                      decoration: const InputDecoration(
                        labelText: "Select *",
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        KDropdownItem(
                          value: "Employees",
                          child: const Text("Employees"),
                        ),
                      ],
                      onChanged: (value) {
                        stateController.onSelectedCategory(value ?? '');
                      },
                    )
                  : KDropdownField<String>(
                      fieldHeading: Text('Category *'),
                      decoration: const InputDecoration(
                        labelText: "Select *",
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        KDropdownItem(
                          value: "Trainee",
                          child: const Text("Trainee"),
                        ),
                        KDropdownItem(value: "Workers", child: Text("Workers")),

                        KDropdownItem(
                          value: "Contractors",
                          child: Text("Contractors"),
                        ),
                      ],
                      onChanged: (value) {
                        stateController.onSelectedCategory(value ?? '');
                      },
                    ),
              12.toVerticalSizedBox,
              Text(
                'Note:- ID Number (For Omanis and Residents) | Passport Number (For Foreigners outside the country)',
              ),
              12.toVerticalSizedBox,
              ...(state.selectedRequestFor.toLowerCase() == 'self'
                  ? [
                      KTextField(
                        fieldHeadingText: 'ID Number *',
                        controller: stateController.employeeIdController,
                        hintText: "Enter Civil ID/Cards Number",
                      ),
                    ]
                  : [
                      KTextField(
                        fieldHeadingText: 'Passport Number *',
                        controller: stateController.employeeIdController,
                        hintText: "Enter Civil ID/Cards Number",
                      ),
                    ]),

              12.toVerticalSizedBox,

              KTextField(
                fieldHeadingText: "Date(optional)",
                hintText: state.date,
                readOnly: true,
                onTap: () async {
                  final date = await KAppX.extendedRouter.showKDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    stateController.onSelectRequestDate(
                      "${date.year}-${date.month}-${date.day}",
                    );
                  }
                },
              ),
              12.toVerticalSizedBox,
              KTextField(
                fieldHeadingText: 'University/Organisation *',
                controller: stateController.uniorOrgcontroller,
                hintText: "Enter",
              ),
              if (state.requestType.toLowerCase() == 'renewal')
                KTextField(
                  fieldHeadingText: 'Access Card No *',
                  controller: stateController.accessCardno,
                  hintText: "Enter",
                ),

              12.toVerticalSizedBox,
              KTextField(
                fieldHeadingText: 'Reason *',
                controller: stateController.reasonController,
                hintText: "Enter Reason ",
              ),
              12.toVerticalSizedBox,

              FileUploadWidget(
                onUploadSuccess: (fileDetails) {
                  stateController.onUploadFileSuccess(fileDetails);
                },
                onDelete: (index) {
                  stateController.onRemoveFile(index);
                },
              ),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    stateController.sendAccessCardRequest();
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
