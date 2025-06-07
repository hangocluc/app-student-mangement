import 'dart:io';

extension FileExtension on File? {
  String get fileName {
    if (this == null) return '';

    return this!.path.split('/').last;
  }

  String get path {
    if (this == null) return '';

    return this!.path;
  }

  String get name {
    if (this == null) return '';

    return this!.path.split('/').last;
  }

  int get size {
    if (this == null) return 0;

    return this!.lengthSync();
  }
}
