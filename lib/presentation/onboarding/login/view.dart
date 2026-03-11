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
class MicrosoftLoginPage extends ConsumerWidget {
  const MicrosoftLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginVsProvider);
    final controller = ref.read(loginVsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Microsoft Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.isLoading)
                const CircularProgressIndicator()
              else ...[
                ElevatedButton(
                  onPressed: () async {
                    await controller.signIn();
                    // ref.read(_vsProvider.notifier).loginWithJwtDirectly();
                  },
                  child: const Text('Sign in with Microsoft'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.signOut,
                  child: const Text('Sign out'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
