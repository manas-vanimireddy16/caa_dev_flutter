part of '../view.dart';

class PassengerComponent extends ConsumerWidget {
  const PassengerComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider);
    final controller = ref.read(_vsProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label + Add Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Name of the Passengers *",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            TextButton.icon(
              onPressed: controller.addPassenger,
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Add Name"),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                side: const BorderSide(color: Colors.black12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Passenger List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.passengers.length,
          itemBuilder: (context, index) {
            final passenger = state.passengers[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: passenger.nameController,
                      decoration: InputDecoration(
                        hintText: "Enter name",
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width: 0.6,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Delete button only after more than 1 passenger
                  if (state.passengers.length > 1)
                    IconButton(
                      onPressed: () => controller.removePassenger(index),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
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
