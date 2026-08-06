import 'package:code_setup/presentation/common_widgets/file_upload.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_notifier.dart';
import 'package:code_setup/presentation/dynamic_form/state/dynamic_form_state.dart';
import 'package:code_setup/presentation/models/file_upload_model.dart';
import 'package:code_setup/utils/helper/dashboard_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContractDocumentDefinition {
  final String documentName;
  final String description;

  const ContractDocumentDefinition({
    required this.documentName,
    required this.description,
  });
}

/// Documents required for contract approval (aligned with web).
const contractDocumentDefinitions = <ContractDocumentDefinition>[
  ContractDocumentDefinition(
    documentName:
        'Commercial Registration Certificate - valid commercial registration for at least (60) sixty days',
    description:
        'السجل التجاري للشركة - سجل تجاري ساري المفعول لمدة لا تقل عن (60) ستين يوماً',
  ),
  ContractDocumentDefinition(
    documentName: 'Omanization Compliance Certificate',
    description: 'شهادة استيفاء التعمين - تعبئة استمارة تقييم الأداء',
  ),
  ContractDocumentDefinition(
    documentName:
        'Attach a statement classifying the institution (small - medium)',
    description: 'ارفاق بيان تصنيف المؤسسة ( صغرى - متوسطة )',
  ),
  ContractDocumentDefinition(
    documentName: 'Membership certificate',
    description: 'شهادة الانتساب سارية الصلاحية',
  ),
  ContractDocumentDefinition(
    documentName: 'Signature specimen or a copy of the personal ID card',
    description: 'نموذج التوقيع أو نسخة البطاقة الشخصية',
  ),
  ContractDocumentDefinition(
    documentName: 'Tax Certificate and VAT Registration Certificate',
    description: 'الشهادة الضريبية وشهادة التسجيل للضريبة القيمة المضافة',
  ),
  ContractDocumentDefinition(
    documentName: 'Financial report for the last three years',
    description: 'الملاءة المالية لآخر 3 سنوات',
  ),
  ContractDocumentDefinition(
    documentName: 'Bank guarantee for advance payment',
    description: 'الضمان البنكي للدفعة المقدمة',
  ),
  ContractDocumentDefinition(
    documentName: 'Non-Disclosure Agreement',
    description: 'اتفاقية عدم الإفصاح (NDA)',
  ),
  ContractDocumentDefinition(
    documentName: 'Municipal license',
    description: 'الترخيص البلدي',
  ),
  ContractDocumentDefinition(
    documentName: 'Performance guarantee: 5% of the contract value',
    description: 'ضمان حسن التنفيذ 5% من قيمة العقد',
  ),
  ContractDocumentDefinition(
    documentName: 'Insurance policy',
    description: 'وثيقة التأمين',
  ),
  ContractDocumentDefinition(
    documentName:
        'Providing a professional insurance policy in the case of companies and consulting offices - 5%',
    description:
        'تقديم وثيقة التأمين مهنية في حالة الشركات والمكاتب الاستشارية - 5%',
  ),
  ContractDocumentDefinition(
    documentName:
        'Foreign companies provide professional insurance policy in the case of companies and consulting offices - 5% (within twenty working days)',
    description:
        'الشركات الخارجية تقديم وثيقة التأمين مهنية في حالة الشركات والمكاتب الاستشارية - 5% ( خلال عشرين يوم عمل )',
  ),
  ContractDocumentDefinition(
    documentName: 'Business licenses',
    description: 'تراخيص مزاولة النشاط',
  ),
  ContractDocumentDefinition(
    documentName: 'Price Offers',
    description: 'عروض الأسعار',
  ),
  ContractDocumentDefinition(
    documentName: 'Tender documents',
    description: 'كراسة المناقصة',
  ),
];

String contractDocCheckedKey(int index) => 'contract_doc_${index}_checked';

String contractDocFileKey(int index) => 'contract_doc_${index}_file';

class ContractDocumentsChecklist extends ConsumerWidget {
  const ContractDocumentsChecklist({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = DashboardL10n.of(context);
    final formState = ref.watch(dynamicFormProvider);
    final notifier = ref.read(dynamicFormProvider.notifier);
    final errorText = formState.errors['contract_documents'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.isArabic ? 'المستندات' : 'Documents',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.isArabic
                ? 'المستندات المطلوبة لاستكمال إجراءات اعتماد العقود.'
                : 'Documents required to complete the contract approval procedures.',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B6B70),
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(contractDocumentDefinitions.length, (index) {
            final doc = contractDocumentDefinitions[index];
            final checked =
                formState.values[contractDocCheckedKey(index)] == true;
            final files =
                (formState.values[contractDocFileKey(index)]
                    is List<FileUploadItem>)
                ? List<FileUploadItem>.from(
                    formState.values[contractDocFileKey(index)],
                  )
                : <FileUploadItem>[];

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE6E6E6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxListTile(
                      value: checked,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${l10n.isArabic ? doc.description : doc.documentName}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2F2F33),
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.isArabic
                                ? doc.documentName
                                : doc.description,
                            textAlign: l10n.isArabic
                                ? TextAlign.right
                                : TextAlign.left,
                            textDirection: l10n.isArabic
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B6B70),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                      onChanged: (value) {
                        final isChecked = value == true;
                        notifier.updateValue(
                          contractDocCheckedKey(index),
                          isChecked,
                        );
                        if (!isChecked) {
                          notifier.updateValue(
                            contractDocFileKey(index),
                            <FileUploadItem>[],
                          );
                        }
                      },
                    ),
                    if (checked)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: FileUploadWidget(
                          title: l10n.attachment,
                          maxFiles: 1,
                          maxFileSizeInMB: 10,
                          isRequired: true,
                          existingFiles: files,
                          allowedExtensions: const [
                            'doc',
                            'docx',
                            'pdf',
                            'png',
                            'jpeg',
                            'jpg',
                          ],
                          onUploadSuccess: (file) {
                            notifier.onUploadFileSuccess(
                              contractDocFileKey(index),
                              file,
                            );
                          },
                          onDelete: (fileIndex) {
                            notifier.onRemoveFile(
                              contractDocFileKey(index),
                              fileIndex,
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                errorText,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
