import 'package:code_setup/presentation/screens/hc_service/models/goal_weight_model.dart';
import 'package:flutter/material.dart';

class GoalsTable extends StatefulWidget {
  final List<GoalModel> goals;
  final bool isOnHold;

  const GoalsTable({super.key, required this.goals, required this.isOnHold});

  @override
  State<GoalsTable> createState() => _GoalsTableState();
}

class _GoalsTableState extends State<GoalsTable> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    int totalWeight = widget.goals.fold(
      0,
      (sum, g) => sum + (g.goalWeight ?? 0),
    );

    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          /// HEADER
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.shade200,
            child: const Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Goal Title",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Weight %",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 24), // space for chevron column
              ],
            ),
          ),

          /// BODY
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.goals.length,
            itemBuilder: (context, index) {
              final goal = widget.goals[index];
              bool isExpanded = expandedIndex == index;

              return InkWell(
                onTap: widget.isOnHold
                    ? () {
                        setState(() {
                          expandedIndex = isExpanded ? null : index;
                        });
                      }
                    : null,
                child: Column(
                  children: [
                    /// MAIN ROW
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              goal.goalTitle ?? "-",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              goal.goalDescription ?? "-",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text("${goal.goalWeight ?? 0}%"),
                          ),

                          /// CHEVRON
                          AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0, // rotate ▼ to ▲
                            duration: const Duration(milliseconds: 250),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: widget.isOnHold
                                  ? Colors.black54
                                  : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// EXPANDED FULL TEXT
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 250),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: const SizedBox(),
                      secondChild: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
                        color: Colors.blueGrey.withOpacity(.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              goal.goalTitle ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(goal.goalDescription ?? ""),
                          ],
                        ),
                      ),
                    ),

                    Divider(height: 1),
                  ],
                ),
              );
            },
          ),

          /// TOTAL
          Container(
            padding: const EdgeInsets.all(14),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                const Expanded(
                  flex: 7,
                  child: Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "$totalWeight%",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
