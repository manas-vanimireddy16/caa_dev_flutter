import 'package:flutter/material.dart';

class PassengerUIModel {
  final TextEditingController nameController;

  PassengerUIModel() : nameController = TextEditingController();

  void dispose() {
    nameController.dispose();
  }

  Map<String, String> toMap() => {"name": nameController.text};
}
