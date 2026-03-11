enum FileType { video, image, unknown, document, audio, pdf }

FileType getFileTypeFromPath(String path) {
  final extension = path.split('.').last.toLowerCase();
  switch (extension) {
    case 'mp4':
    case 'mov':
    case 'avi':
    case 'm4v':
    case '3gp':
      return FileType.video;
    case 'jpg':
    case 'jpeg':
    case 'png':
      return FileType.image;
    case 'pdf':
      return FileType.document;
    default:
      return FileType.unknown;
  }
}

String mapCategoryToMessageType(FileType category) {
  switch (category) {
    case FileType.image:
      return 'image';
    case FileType.video:
    case FileType.audio:
    case FileType.pdf:
    case FileType.document:
      return 'file';
    default:
      return 'file';
  }
}
