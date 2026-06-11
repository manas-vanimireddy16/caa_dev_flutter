import 'package:code_setup/presentation/common_widgets/dialog_config.dart';
import 'package:flutter/material.dart';

class SelectionDialog extends StatelessWidget {
  final SelectionDialogConfig config;

  const SelectionDialog({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                config.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          const Divider(),

          if (config.isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else
            Expanded(
              child: ListView.separated(
                itemCount: config.items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, index) {
                  final item = config.items[index];

                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text("${item.taskCount} active tasks"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => config.onItemSelected(item),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
