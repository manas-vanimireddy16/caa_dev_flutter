typedef MyRequestsTabPageSyncHandler = void Function(int index);

/// Shared registry so controllers can sync [PageView] tabs without
/// adding per-screen controller fields.
class MyRequestsTabPageSyncRegistry {
  MyRequestsTabPageSyncRegistry._();

  static final Map<String, MyRequestsTabPageSyncHandler> _handlers = {};

  static String keyFor({required int? serviceId, required int? subServiceId}) =>
      '${serviceId ?? 0}-${subServiceId ?? 0}';

  static void register({
    required int? serviceId,
    required int? subServiceId,
    required MyRequestsTabPageSyncHandler handler,
  }) {
    _handlers[keyFor(serviceId: serviceId, subServiceId: subServiceId)] =
        handler;
  }

  static void unregister({required int? serviceId, required int? subServiceId}) {
    _handlers.remove(keyFor(serviceId: serviceId, subServiceId: subServiceId));
  }

  static void syncToTab({
    required int? serviceId,
    required int? subServiceId,
    required int index,
  }) {
    _handlers[keyFor(serviceId: serviceId, subServiceId: subServiceId)]
        ?.call(index);
  }
}
