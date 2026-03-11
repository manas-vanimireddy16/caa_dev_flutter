import 'package:flutter/material.dart';

class AreaPermission {
  final int id;
  final String name;
  final Color color;

  AreaPermission({required this.id, required this.name, required this.color});

  // This is optional but recommended
  @override
  bool operator ==(Object other) => other is AreaPermission && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => "AreaPermission(id: $id, name: $name)";
}
