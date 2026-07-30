export 'airport_permit_approval_validator.dart';
export 'airport_permit_area_mapper.dart';
export 'airport_permit_pdf_colors.dart';
export 'airport_permit_pdf_constants.dart';
export 'airport_permit_pdf_data.dart';
export 'airport_permit_pdf_file_saver.dart';
export 'airport_permit_pdf_generator.dart';

import 'package:code_setup/presentation/models/details_models.dart';
import 'package:code_setup/presentation/screens/aviation_security_Facilitation/airport_entry_permit/pdf/airport_permit_approval_validator.dart';

/// Public helper matching the React print-enable gate.
///
/// Pass the Airport Entry `RequestDetailData` (RequestById response).
bool shouldShowDownloadButton(RequestDetailData response) {
  return AirportPermitApprovalValidator.shouldShowDownloadButton(response);
}
