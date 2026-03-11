import 'package:code_setup/presentation/screens/logistics/models/activityField.dart';
import 'package:code_setup/presentation/screens/logistics/widgets/activityTile.dart';
import 'package:flutter/material.dart';

class ActivityFeed extends StatelessWidget {
  final List<ActivityFeedData> activities;

  const ActivityFeed({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Card(
        color: Colors.white,
        elevation: 1,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 8),
              // Scrollable part
              Expanded(
                child: ListView.separated(
                  physics:
                      const BouncingScrollPhysics(), // optional nice scroll effect
                  itemCount: activities.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 4), // no divider line at end
                  itemBuilder: (context, index) {
                    return ActivityTile(item: activities[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.trending_up, color: Colors.orange),
        ),
        const SizedBox(width: 8),
        Text(
          "Activity Feed",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
