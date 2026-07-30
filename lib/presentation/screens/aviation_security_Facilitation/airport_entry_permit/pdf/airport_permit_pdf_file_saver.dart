import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Saves PDF bytes to device storage and opens the file.
abstract final class AirportPermitPdfFileSaver {
  AirportPermitPdfFileSaver._();

  static Future<File> saveAndOpen({
    required Uint8List bytes,
    required String fileName,
  }) async {
    await _ensureStoragePermission();

    final directory = await _resolveDirectory();
    final file = File('${directory.path}${Platform.pathSeparator}$fileName');
    await file.writeAsBytes(bytes, flush: true);

    final result = await OpenFilex.open(file.path);
    if (result.type != ResultType.done) {
      debugPrint('OpenFilex result: ${result.type} ${result.message}');
    }
    return file;
  }

  static Future<Directory> _resolveDirectory() async {
    // Prefer app documents — always writable without legacy storage permission.
    // Falls back gracefully on all platforms; open_filex opens the saved file.
    return getApplicationDocumentsDirectory();
  }

  static Future<void> _ensureStoragePermission() async {
    if (!Platform.isAndroid && !Platform.isIOS) return;

    // Android 13+ / iOS usually do not need legacy storage permission for
    // app-owned or public Download writes via scoped access.
    final status = await Permission.storage.status;
    if (status.isGranted || status.isLimited) return;

    final result = await Permission.storage.request();
    if (result.isGranted || result.isLimited || result.isDenied) {
      // Continue; Download folder write may still succeed on modern Android.
      return;
    }
  }
}
