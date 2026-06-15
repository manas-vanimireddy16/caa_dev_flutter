// import 'package:code_setup/presentation/models/allowance_employee.dart';
// import 'package:flutter/material.dart';

// class AllowanceTable extends StatelessWidget {
//   final List<AllowanceEmployee> employees;

//   const AllowanceTable({super.key, required this.employees});

//   double get netAmount => employees.fold(0, (sum, e) => sum + e.totalAmount);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Divider(color: Colors.grey.shade300),

//         _row(
//           name: "Employee Name",
//           perDay: "Allowance / Day",
//           total: "Total Amount",
//           isHeader: true,
//         ),

//         Divider(color: Colors.grey.shade300),

//         ...employees.map(
//           (e) => _row(
//             name: e.employeeName,
//             perDay: e.allowancePerDay.toStringAsFixed(2),
//             total: e.totalAmount.toStringAsFixed(2),
//           ),
//         ),

//         Divider(color: Colors.grey.shade300),

//         Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             "Net Amount ${netAmount.toStringAsFixed(2)}",
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _row({
//     required String name,
//     required String perDay,
//     required String total,
//     bool isHeader = false,
//   }) {
//     final style = TextStyle(
//       fontSize: 13,
//       fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
//       color: isHeader ? Colors.grey.shade600 : Colors.black,
//     );

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 4,
//             child: Text(
//               name,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis, // ✅ long name handled
//               style: style,
//             ),
//           ),
//           Expanded(flex: 2, child: Text(perDay, style: style)),
//           Expanded(
//             flex: 2,
//             child: Text(total, textAlign: TextAlign.right, style: style),
//           ),
//         ],
//       ),
//     );
//   }
// }
