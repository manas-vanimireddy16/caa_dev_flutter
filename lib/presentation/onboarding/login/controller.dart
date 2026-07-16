part of 'view.dart';

final loginVsProvider =
    StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
      final stateController = _VSController();
      stateController.initState();
      return stateController;
    });

class _ViewState {
  final bool isLoading;
  final UserRoleResponse userRoles;
  final UserInformation userInfo;
  _ViewState({
    required this.isLoading,
    required this.userRoles,
    required this.userInfo,
  });

  _ViewState.init()
    : this(
        isLoading: false,
        userRoles: UserRoleResponse(),
        userInfo: UserInformation(),
      );

  _ViewState copyWith({
    bool? isLoading,
    UserRoleResponse? userRoles,
    UserInformation? userInfo,
  }) {
    return _ViewState(
      isLoading: isLoading ?? this.isLoading,
      userRoles: userRoles ?? this.userRoles,
      userInfo: userInfo ?? this.userInfo,
    );
  }
}

class _VSController extends StateNotifier<_ViewState> {
  _VSController() : super(_ViewState.init());

  late SingleAccountPca msal;
  String accessToken = '';
  bool _isSigningIn = false;

  void initState() {
    initializeMsal();

    // Check if a user session already exists on app start
    userSession();
  }

  Future<void> initializeMsal() async {
    try {
      msal = await SingleAccountPca.create(
        clientId: '80314aeb-8563-4924-bbf3-b0a76e75a73c',
        androidConfig: AndroidConfig(
          configFilePath: 'assets/msal_config.json',
          redirectUri:
              'msauth://com.example.sso_testing/+yTKwzXT6K1fl0HQWwIryOQSHEw=',
        ),
        appleConfig: AppleConfig(
          authority:
              "https://login.microsoftonline.com/a0d55139-70f6-49e4-b912-4d13d30fc66b",
          authorityType: AuthorityType.aad,
          broker: Broker.safariBrowser,
        ),
      );
      debugPrint('✅ MSAL initialized successfully');
    } catch (e) {
      debugPrint('❌ MSAL Initialization Error: $e');
    }
  }

  Future<void> signIn() async {
    if (_isSigningIn) return;

    _isSigningIn = true;
    state = state.copyWith(isLoading: true);

    try {
      debugPrint('🔄 Attempting to acquire token...');
      AuthenticationResult result = await msal.acquireToken(
        scopes: ['user.read'],
      );

      debugPrint(
        '✅ Token acquired successfully! accessToken: ${result.accessToken}',
      );
      accessToken = result.accessToken;

      await onGettingSSOAccessTokenFetchAuthToken(accessToken);
    } catch (e) {
      debugPrint('❌ ERROR DURING LOGIN: $e');
      _isSigningIn = false;
      state = state.copyWith(isLoading: false);
    }
  }

  UserRoleResponse _wrapSelectedRole(SelectedUserRole sel) {
    return UserRoleResponse(
      status: "success",
      data: UserData(
        userId: 0,
        totalRoles: 1,
        rolesSummary: [RoleSummary(roleId: sel.roleId, roleName: sel.roleName)],
        roleDetails: [
          RoleDetail(
            userRoleId: 0,
            isActive: true,
            role: Role(id: sel.roleId, name: sel.roleName),
            department: Department(id: sel.departmentId, departmentName: ""),
            section: Section(id: sel.sectionId, sectionName: ""),
            services: [],
          ),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await _signOutMsalIfNeeded();
    accessToken = '';
    if (mounted) {
      state = _ViewState.init();
    }
    await KAuthCred().logoutToLogin();
  }

  Future<void> _signOutMsalIfNeeded() async {
    try {
      await msal.signOut();
    } on MsalException catch (e) {
      if (!e.message.toLowerCase().contains('no currently signed in account')) {
        rethrow;
      }
      debugPrint('No MSAL account cached; clearing local session only.');
    }
  }

  Future<void> onGettingSSOAccessTokenFetchAuthToken(String accessToken) async {
    try {
      final authRepo = AuthRepository();

      final response = await authRepo.getAuthTokenWithSSOAccessToken(
        accessToken,
      );

      if (response != null && response.isNotEmpty) {
        final authToken = response['token'];
        await decodeJwtPayloadSafe(authToken);
      } else {
        _isSigningIn = false;
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      debugPrint('❌ Auth token fetch error: $e');
      _isSigningIn = false;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchUserRoles(int id) async {
    if (!_isSigningIn) {
      state = state.copyWith(isLoading: true);
    }
    try {
      final repo = RolesRepo();
      final userRoles = await repo.getUserRoles(id);

      // Now select role
      await selectOrStoreRole(userRoles);

      if (!_isSigningIn) {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      debugPrint("fetchUserRoles error: $e");
      if (!_isSigningIn) {
        state = state.copyWith(isLoading: false);
      } else {
        _isSigningIn = false;
        state = state.copyWith(isLoading: false);
      }
    }
  }

  // ------------------------------------------------------------
  // 3️⃣ ROLE SELECTION LOGIC
  // ------------------------------------------------------------
  Future<void> selectOrStoreRole(UserRoleResponse userRoles) async {
    final storage = KAuthCred();
    final saved = await storage.getSelectedRole();

    if (saved != null) {
      print("🔵 Using saved role ${saved.roleName}");
      // state = state.copyWith(userRoles: _wrapSelectedRole(saved));
      return;
    }

    // First role from summary
    final first = userRoles.data!.rolesSummary!.first;

    // Match it inside role_details
    final detail = userRoles.data!.roleDetails!.firstWhere(
      (e) => e.role?.id == first.roleId,
      orElse: () => userRoles.data!.roleDetails!.first,
    );

    final selected = SelectedUserRole(
      roleId: first.roleId!,
      roleName: first.roleName!,
      departmentId: detail.department?.id ?? 0,
      sectionId: detail.section?.id ?? 0,
      services: detail.services ?? [],
    );

    await storage.storeSelectedRole(selected);

    // state = state.copyWith(userRoles: _wrapSelectedRole(saved!));

    print("🎯 Selected Role: ${selected.services}");
  }

  Future<void> fetchUserInfo(int id) async {
    if (!_isSigningIn) {
      state = state.copyWith(isLoading: true);
    }
    try {
      final rolesRepo = RolesRepo();
      final userInfo = await rolesRepo.getUserInfo(id);
      print(userInfo);
      print(userInfo?.data?.section?.id);
      state = state.copyWith(userInfo: userInfo);
      if (!_isSigningIn) {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      debugPrint('Error fetching user roles: $e');
      if (!_isSigningIn) {
        state = state.copyWith(isLoading: false);
      } else {
        _isSigningIn = false;
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> decodeJwtPayloadSafe(String token) async {
    // token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEwMTMsImlzX2FkbWluIjpmYWxzZSwiZW1wbG95ZWVfaWQiOiIxMjgwNSIsImVtcGxveWVlX25hbWUiOiJTYW1iYSBSYWp1IiwiZW1wbG95ZWVfYXJhYmljX25hbWUiOiLYrdmF2YrYryDYqNmGINmF2K3ZhdivINio2YYg2KPYrdmF2K8g2KfZhNi52KfZhdix2YoiLCJwZXJzb25fdHlwZSI6IkNBQSIsInNlY3Rpb24iOjEwMSwic2VjdGlvbl9uYW1lIjoiVGVjaG5pY2FsIFN1cHBvcnQgU2VjdGlvbiIsInBvc2l0aW9uIjo3OCwicG9zaXRpb25fbmFtZSI6IkhlYWQgb2YgTmV0d29ya3MgU2VjdGlvbiIsImRlcGFydG1lbnQiOjUwLCJkZXBhcnRtZW50X25hbWUiOiJJbmZvcm1hdGlvbiBUZWNobm9sb2d5IERlcGFydG1lbnQiLCJlbWFpbCI6InNhbWJhQGFtbmV0ZGlnaXRhbC5jb20iLCJpYXQiOjE3NjM5ODU5NTQsImV4cCI6MTc2NzU4NTk1NH0.NpDfj2gLljd4FKFN2F3Ojk4XJ2UX4d2dbumrj0JDHxU';
    final kAuthCred = KAuthCred();

    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        throw FormatException('Invalid JWT token structure');
      }

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decodedBytes = base64Url.decode(normalized);
      final decodedString = utf8.decode(decodedBytes);
      final payloadMap = json.decode(decodedString);
      payloadMap['accessToken'] = token;
      log('user details - $payloadMap');
      if (payloadMap is! Map<String, dynamic>) {
        throw FormatException('Payload is not a valid JSON object');
      }

      final User user = User.fromJson(payloadMap);

      // Store user profile data
      await kAuthCred.storeProfileData(user);
      if (user.userId != null) {
        await fetchUserRoles(user.userId ?? 0); //(user.userId ?? 0);

        await fetchUserInfo(user.userId ?? 0); //(
        //   user.userId ?? 0,

        // You can also store the role locally if needed:
        // if (state.userRoles.data != null) {
        //   await kAuthCred.storeSelectedRole(state.userRoles);
        // }
        if (state.userInfo.data != null) {
          await kAuthCred.storeUserInfo(state.userInfo);
        }
      }
      // Navigate based on user session
      userSession();
    } on FormatException catch (e) {
      log('FormatException while decoding JWT: $e');
      _isSigningIn = false;
      state = state.copyWith(isLoading: false);
    } catch (e) {
      log('Unexpected error decoding JWT: $e');
      _isSigningIn = false;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loginWithJwt(String token) async {
    if (_isSigningIn) return;

    _isSigningIn = true;
    state = state.copyWith(isLoading: true);

    try {
      await decodeJwtPayloadSafe(token);
    } catch (e) {
      debugPrint("JWT Login Error: $e");
      _isSigningIn = false;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> logoutJwt() async {
    try {
      if (mounted) {
        state = state.copyWith(isLoading: true);
      }

      accessToken = '';
      if (mounted) {
        state = _ViewState.init();
      }

      await KAuthCred().logoutToLogin();
      debugPrint("✅ JWT Logout Successful");
    } catch (e) {
      debugPrint("❌ Logout Error: $e");
    } finally {
      if (mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> userSession() async {
    final auth = KAuthCred();
    await auth.hydrateProvidersFromStorage();
    final profile = KAppX.globalProvider.read(userProvider);

    if (profile?.accessToken != null) {
      KAppX.router.replace(HomeRoute());
    } else {
      KAppX.router.replace(MicrosoftLoginRoute());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// part of 'view.dart';

// // -------------------------------------------------------------
// // PROVIDER
// // -------------------------------------------------------------
// final _vsProvider =
//     StateNotifierProvider.autoDispose<_VSController, _ViewState>((ref) {
//       final controller = _VSController();
//       // controller.initState();
//       return controller;
//     });

// // -------------------------------------------------------------
// // STATE
// // -------------------------------------------------------------
// class _ViewState {
//   final bool isLoading;
//   final UserRoleResponse userRoles;
//   final UserInformation userInfo;

//   _ViewState({
//     required this.isLoading,
//     required this.userRoles,
//     required this.userInfo,
//   });

//   _ViewState.init()
//     : this(
//         isLoading: false,
//         userRoles: UserRoleResponse(),
//         userInfo: UserInformation(),
//       );

//   _ViewState copyWith({
//     bool? isLoading,
//     UserRoleResponse? userRoles,
//     UserInformation? userInfo,
//   }) {
//     return _ViewState(
//       isLoading: isLoading ?? this.isLoading,
//       userRoles: userRoles ?? this.userRoles,
//       userInfo: userInfo ?? this.userInfo,
//     );
//   }
// }

// // -------------------------------------------------------------
// // CONTROLLER
// // -------------------------------------------------------------
// class _VSController extends StateNotifier<_ViewState> {
//   _VSController() : super(_ViewState.init());

//   // -------------------------------------------------------------
//   // LOGIN DIRECTLY USING JWT (NO MSAL)
//   // -------------------------------------------------------------
//   Future<void> loginWithJwtDirectly() async {
//     const jwt =
//         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEwMTMsImlzX2FkbWluIjpmYWxzZSwiZW1wbG95ZWVfaWQiOiIxMjgwNSIsImVtcGxveWVlX25hbWUiOiJTYW1iYSBSYWp1IiwiZW1wbG95ZWVfYXJhYmljX25hbWUiOiLYrdmF2YrYryDYqNmGINmF2K3ZhdivINio2YYg2KPYrdmF2K8g2KfZhNi52KfZhdix2YoiLCJwZXJzb25fdHlwZSI6IkNBQSIsInNlY3Rpb24iOjEwMSwic2VjdGlvbl9uYW1lIjoiVGVjaG5pY2FsIFN1cHBvcnQgU2VjdGlvbiIsInBvc2l0aW9uIjo3OCwicG9zaXRpb25fbmFtZSI6IkhlYWQgb2YgTmV0d29ya3MgU2VjdGlvbiIsImRlcGFydG1lbnQiOjUwLCJkZXBhcnRtZW50X25hbWUiOiJJbmZvcm1hdGlvbiBUZWNobm9sb2d5IERlcGFydG1lbnQiLCJlbWFpbCI6InNhbWJhQGFtbmV0ZGlnaXRhbC5jb20iLCJpYXQiOjE3NjM5ODU5NTQsImV4cCI6MTc2NzU4NTk1NH0.NpDfj2gLljd4FKFN2F3Ojk4XJ2UX4d2dbumrj0JDHxU";

//     decodeJwtPayloadSafe(jwt);
//   }

//   // -------------------------------------------------------------
//   // DECODE JWT
//   // -------------------------------------------------------------
//   Future<void> decodeJwtPayloadSafe(String token) async {
//     final kAuthCred = KAuthCred();

//     try {
//       final parts = token.split('.');
//       if (parts.length != 3) throw FormatException("Invalid JWT");

//       final payload = base64Url.normalize(parts[1]);
//       final decodedString = utf8.decode(base64Url.decode(payload));
//       final payloadMap = json.decode(decodedString);

//       payloadMap['accessToken'] = token;

//       final user = User.fromJson(payloadMap);

//       // Save user in local storage
//       await kAuthCred.storeProfileData(user);

//       // Fetch roles & user info
//       if (user.userId != null) {
//         await fetchUserRoles(user.userId!);
//         await fetchUserInfo(user.userId!);
//       }

//       if (state.userRoles.data != null) {
//         await kAuthCred.storeRoleData(state.userRoles);
//       }

//       if (state.userInfo.data != null) {
//         await kAuthCred.storeUserInfo(state.userInfo);
//       }

//       // After everything → redirect
//       userSession();
//     } catch (e) {
//       log("JWT Decode Error: $e");
//     }
//   }

//   // -------------------------------------------------------------
//   // FETCH
//   // -------------------------------------------------------------
//   Future<void> fetchUserRoles(int id) async {
//     try {
//       final rolesRepo = RolesRepo();
//       final userRoles = await rolesRepo.getUserRoles(id);
//       state = state.copyWith(userRoles: userRoles);
//     } catch (e) {
//       debugPrint("Error fetching roles: $e");
//     }
//   }

//   Future<void> fetchUserInfo(int id) async {
//     try {
//       final rolesRepo = RolesRepo();
//       final userInfo = await rolesRepo.getUserInfo(id);
//       state = state.copyWith(userInfo: userInfo);
//     } catch (e) {
//       debugPrint("Error fetching info: $e");
//     }
//   }

//   // -------------------------------------------------------------
//   // LOGOUT
//   // -------------------------------------------------------------
//   Future<void> logout() async {
//     await KAuthCred().deleteProfileData();
//     // await KAuthCred().deleteRoleData();
//     // await KAuthCred().deleteUserInfo();

//     KAppX.router.replace(MicrosoftLoginRoute());
//   }

//   // -------------------------------------------------------------
//   // SESSION CHECK
//   // -------------------------------------------------------------
//   void userSession() {
//     KAuthCred().getProfileData().then((userInfo) {
//       if (userInfo?.accessToken != null) {
//         KAppX.router.replace(HomeRoute());
//       } else {
//         KAppX.router.replace(MicrosoftLoginRoute());
//       }
//     });
//   }
// }
