import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/domain/models/roles_model.dart';
import 'package:code_setup/modules/domain/models/selected_role.dart';
import 'package:code_setup/modules/domain/models/user_model.dart'
    hide UserData, Department, Section;
import 'package:code_setup/modules/domain/roles_repo.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/repository/authentication/domain.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msal_auth/msal_auth.dart';

part 'controller.dart';

@RoutePage()
// class MicrosoftLoginPage extends ConsumerWidget {
//   const MicrosoftLoginPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(loginVsProvider);
//     final controller = ref.read(loginVsProvider.notifier);
//     return Scaffold(
//       appBar: AppBar(title: const Text('Microsoft Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (state.isLoading)
//                 const CircularProgressIndicator()
//               else ...[
//                 ElevatedButton(
//                   onPressed: () async {
//                     await controller.signIn();
//                     // ref.read(_vsProvider.notifier).loginWithJwtDirectly();
//                   },
//                   child: const Text('Sign in with Microsoft'),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: controller.signOut,
//                   child: const Text('Sign out'),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class MicrosoftLoginPage extends ConsumerWidget {
  const MicrosoftLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginVsProvider);
    final controller = ref.read(loginVsProvider.notifier);

    final TextEditingController jwtController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// 🔷 LOGO / ICON
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_outline_rounded,
                      size: 45,
                      color: Colors.blue.shade700,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// TITLE
                  const Text(
                    "CIVIL AVIATION AUTHORITY",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Login using Microsoft account or JWT token",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 35),

                  /// LOADER
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: CircularProgressIndicator(),
                    )
                  else ...[
                    /// MICROSOFT LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await controller.signIn();
                        },
                        icon: const Icon(Icons.login),
                        label: const Text(
                          "Sign in with Microsoft",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    /// SIGN OUT BUTTON

                    /// DIVIDER
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// JWT FIELD
                    TextField(
                      controller: jwtController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Paste your JWT token here...",
                        labelText: "JWT Token",
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.blue.shade700,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// JWT LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () async {
                          final token = jwtController.text.trim();

                          if (token.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter JWT token"),
                              ),
                            );
                            return;
                          }

                          await controller.loginWithJwt(token);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "Login with JWT",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
