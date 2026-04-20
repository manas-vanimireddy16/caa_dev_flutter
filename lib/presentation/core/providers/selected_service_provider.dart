import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedServiceProvider = StateProvider<SelectedServiceState>((ref) {
  return SelectedServiceState.initial();
});

class SelectedServiceState {
  final Service service;
  final SubService subService;

  SelectedServiceState({required this.service, required this.subService});

  factory SelectedServiceState.initial() {
    return SelectedServiceState(service: Service(), subService: SubService());
  }

  SelectedServiceState copyWith({Service? service, SubService? subService}) {
    return SelectedServiceState(
      service: service ?? this.service,
      subService: subService ?? this.subService,
    );
  }
}
