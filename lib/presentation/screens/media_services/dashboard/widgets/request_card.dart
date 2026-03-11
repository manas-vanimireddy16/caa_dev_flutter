import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceRequestCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback? onTap;

  const ServiceRequestCard({super.key, required this.data, this.onTap});

  String _formatDate(String date) {
    try {
      return DateFormat('dd MMM, yyyy').format(DateTime.parse(date));
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ───────── HEADER ─────────
              Row(
                children: [
                  Expanded(
                    child: Text(
                      data['title'] ?? '-',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _StatusChip(status: data['status']),
                ],
              ),

              const SizedBox(height: 12),

              Row(children: [_TagChip(label: data['coverageType'])]),

              const SizedBox(height: 16),

              /// ───────── DETAILS (2 PER ROW) ─────────
              _infoRow(
                _InfoItem(
                  label: 'Scheduled Date',
                  value: _formatDate(data['date']),
                ),
                _InfoItem(label: 'Time', value: data['time'] ?? '-'),
              ),

              _infoRow(
                _InfoItem(
                  label: 'Attendees',
                  value: data['attendees']?.toString() ?? '-',
                ),
                _InfoItem(
                  label: 'Requested By',
                  value: data['requestedBy'] ?? '-',
                ),
              ),

              _infoRow(
                _InfoItem(label: 'Contact', value: data['contact'] ?? '-'),
                _InfoItem(
                  label: 'Coverage Type',
                  value: data['coverageType'] ?? '-',
                ),
              ),

              _infoRow(
                _InfoItem(label: 'Files', value: data['files'] ?? 'N/A'),
                _InfoItem(label: 'Location', value: data['location'] ?? '-'),
              ),

              const SizedBox(height: 12),
              const Divider(),

              /// ───────── FOOTER ─────────
              Text(
                'Posted on ${_formatDate(data['postedOn'])} • ${data['department']}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper to build 2-column rows
  Widget _infoRow(Widget left, Widget right) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(child: left),
          const SizedBox(width: 16),
          Expanded(child: right),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String? status;

  const _StatusChip({this.status});

  @override
  Widget build(BuildContext context) {
    final isApproved = status?.toLowerCase() == 'approved';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isApproved ? Colors.green.shade50 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status ?? '-',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isApproved ? Colors.green : Colors.black87,
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String? label;

  const _TagChip({this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label ?? '-',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}
