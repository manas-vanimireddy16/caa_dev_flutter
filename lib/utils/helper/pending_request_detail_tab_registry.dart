/// Stores a one-shot initial tab when navigating to request details from
/// dashboard routes that do not go through a service controller.
class PendingRequestDetailTabRegistry {
  PendingRequestDetailTabRegistry._();

  static final Map<String, int> _pending = {};

  static String _key(int serviceId, int subServiceId) =>
      '$serviceId-$subServiceId';

  static void set({
    required int serviceId,
    required int subServiceId,
    required int tabIndex,
  }) {
    _pending[_key(serviceId, subServiceId)] = tabIndex;
  }

  static int? consumeIfPresent({
    required int serviceId,
    required int subServiceId,
  }) {
    return _pending.remove(_key(serviceId, subServiceId));
  }
}
