part of '../view.dart';

class PassengerNamesWidget extends ConsumerStatefulWidget {
  final int passengerCount;
  final Service service;
  final SubService subService;

  const PassengerNamesWidget({
    super.key,
    required this.passengerCount,
    required this.service,
    required this.subService,
  });

  @override
  ConsumerState<PassengerNamesWidget> createState() =>
      _PassengerNamesWidgetState();
}

class _PassengerNamesWidgetState extends ConsumerState<PassengerNamesWidget> {
  late _VSControllerParams _providerArgs;

  @override
  void initState() {
    super.initState();

    _providerArgs = _VSControllerParams(
      service: widget.service,
      subService: widget.subService,
    );
  }

  @override
  void didUpdateWidget(covariant PassengerNamesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// passenger count changed
    if (oldWidget.passengerCount != widget.passengerCount) {
      Future.microtask(() {
        final notifier = ref.read(_vsProvider(_providerArgs).notifier);

        final state = ref.read(_vsProvider(_providerArgs));

        final currentCount = state.passengerNames.length;

        /// Add missing fields
        if (widget.passengerCount > currentCount) {
          final diff = widget.passengerCount - currentCount;

          for (int i = 0; i < diff; i++) {
            notifier.addPassenger();
          }
        }
        /// Remove extra fields
        else if (widget.passengerCount < currentCount) {
          final diff = currentCount - widget.passengerCount;

          for (int i = 0; i < diff; i++) {
            notifier.removeLastPassenger();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_vsProvider(_providerArgs));

    final notifier = ref.read(_vsProvider(_providerArgs).notifier);

    final passengers = state.passengerNames;

    if (widget.passengerCount == 0) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Name of the Passenger",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 12),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: passengers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: passengers[index],
                      decoration: InputDecoration(
                        hintText: "Enter passenger ${index + 1} name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        notifier.updatePassenger(index, value);
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  if (passengers.length > 1)
                    IconButton(
                      onPressed: () {
                        notifier.removePassenger(index);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
