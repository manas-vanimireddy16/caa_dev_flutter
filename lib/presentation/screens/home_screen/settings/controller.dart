part of 'view.dart';

final settingsProvider =
    StateNotifierProvider.autoDispose<SettingsController, SettingsState>((ref) {
      final stateController = SettingsController(ref);
      stateController.initState();
      return stateController;
    });

class SettingsController extends StateNotifier<SettingsState> {
  final Ref ref;
  late SingleAccountPca msal;

  void initState() {
    initializeMsal();
    _loadSavedLanguage();
    final user = KAppX.globalProvider.read(userInfoProvider);
    final int id = int.tryParse(user?.data?.id ?? '') ?? 0;
    fetchUserRoles(id); // //(1017);(id); //(40);(id); //
  }

  void _loadSavedLanguage() {
    final code = Hive.box('language').get('lang', defaultValue: 'en') as String;
    final language = state.languageList.firstWhere(
      (l) => l.code == code,
      orElse: () => state.languageList.first,
    );
    state = state.copyWith(selectedLanguage: language);
  }

  SettingsController(this.ref) : super(SettingsState.initial());

  void onToggleTheme(bool value) {
    // TODO: integrate with your actual theme service
    // Example (adjust to your implementation):
    // final themeController = KAppX.globalProvider.read(KAppX.theme.current);
    // themeController.toggleTheme();
    state = state.copyWith(isDarkMode: value);
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

  Future<void> onSelectRole(RoleDetail role, BuildContext context) async {
    final storage = KAuthCred();

    final selected = SelectedUserRole(
      roleId: role.role?.id ?? 0,
      roleName: role.role?.name ?? '',
      departmentId: role.department?.id ?? 0,
      sectionId: role.section?.id ?? 0,
      services: role.services ?? [],
    );

    await storage.storeSelectedRole(selected);

    state = state.copyWith(
      selectedRole: role,
      selectedRoleName: role.role?.name,
    );

    if (!context.mounted) return;

    final user = KAppX.globalProvider.read(userProvider);
    await ref.read(servicesProvider.notifier).syncWithSelectedRole(
      role: role,
      userId: user?.userId,
    );

    if (!context.mounted) return;

    ref.read(bottomNavigatorVsProvider.notifier).onTabChanged(1);
    AutoTabsRouter.of(context).setActiveIndex(1);

    debugPrint("🔵 Role changed to: ${role.role?.name}");
  }

  Future<void> signOut() async {
    await _signOutMsalIfNeeded();
    await KAuthCred().clearSession();
    KAppX.router.replace(MicrosoftLoginRoute());
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

  Future<void> logoutJwt() async {
    try {
      state = state.copyWith(isLoading: true);

      final storage = KAuthCred();

      // 1️⃣ Clear all stored auth data
      await storage.clearSession();

      // 2️⃣ Clear in-memory token
      // accessToken = '';

      // 3️⃣ Reset state
      // state = _ViewState.init();
      // KAuthCred().getProfileData().then((profile) {
      //   profile?.accessToken = ''; // Should be null or empty
      // });

      // 4️⃣ Navigate to Login
      KAppX.router.replace(MicrosoftLoginRoute());

      debugPrint("✅ JWT Logout Successful");
    } catch (e) {
      debugPrint("❌ Logout Error: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void onSelectRoleById(int roleId) {
    state = state.copyWith(roleId: roleId);
  }

  Future<void> onSelectLanguage(LanguageItem language) async {
    await setAppLocale(ref, language.code);
    state = state.copyWith(selectedLanguage: language);
  }

  Future<void> onLogoutPressed(BuildContext context) async {
    state = state.copyWith(isLoggingOut: true);
    // final loginProvider = KAppX.globalProvider.read(loginVsProvider.notifier);
    try {
      await signOut();
      // TODO: Clear auth credentials here
      // await AuthCred.clear();

      // TODO: Navigate to login / splash screen using AutoRoute
      // context.replaceRoute(const LoginRoute());
    } finally {
      state = state.copyWith(isLoggingOut: false);
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

  Future<void> loadSavedRole(UserRoleResponse userRoles) async {
    final storage = KAuthCred();
    final saved = await storage.getSelectedRole();
    if (!mounted) return;

    if (saved != null) {
      // find exact matching RoleDetail instance
      final matching = userRoles.data?.roleDetails?.firstWhere(
        (e) => e.role?.id == saved.roleId,
        orElse: () => userRoles.data!.roleDetails!.first,
      );

      state = state.copyWith(
        selectedRole: matching,
        selectedRoleName: saved.roleName,
        // services: matching?.services ?? [],
      );

      print("🔵 Loaded saved role: ${saved.roleName}");
      return;
    }

    // No saved role → show first role only
    final first = userRoles.data!.roleDetails!.first;

    state = state.copyWith(
      selectedRole: first,
      selectedRoleName: first.role?.name,
    );

    print("🎯 Defaulting to first role: ${first.role?.name}");
  }

  Future<void> selectOrStoreRole(UserRoleResponse userRoles) async {
    final storage = KAuthCred();
    final saved = await storage.getSelectedRole();

    if (saved != null) {
      print("🔵 Using saved role ${saved.roleName}");
      state = state.copyWith(selectedRoleName: saved.roleName);
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

    print("🎯 Selected Role: ${selected.roleName}");
  }

  Future<void> fetchUserRoles(int id) async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);

    try {
      final repo = RolesRepo();
      final userRoles = await repo.getUserRoles(id);
      if (!mounted) return;

      state = state.copyWith(userRoles: userRoles);
      await loadSavedRole(userRoles);
      if (!mounted) return;

      state = state.copyWith(isLoading: false);
    } catch (e) {
      debugPrint("fetchUserRoles error: $e");
      if (mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }
}

///
class RoleItem {
  final int id;
  final String name;

  const RoleItem({required this.id, required this.name});
}

class LanguageItem {
  final String code;
  final String name;

  const LanguageItem({required this.code, required this.name});
}

class SettingsState {
  final bool isDarkMode;
  final UserRoleResponse roleList;
  final RoleDetail? selectedRole;
  final String? selectedRoleName;
  final int roleId;
  final List<LanguageItem> languageList;
  final LanguageItem? selectedLanguage;
  final bool isLoggingOut;
  final bool isLoading;
  final UserRoleResponse userRoles;

  const SettingsState({
    required this.isDarkMode,
    required this.roleList,
    required this.selectedRole,
    required this.languageList,
    required this.selectedLanguage,
    required this.isLoggingOut,
    required this.isLoading,
    required this.userRoles,
    required this.roleId,
    required this.selectedRoleName,
  });

  factory SettingsState.initial() {
    // You can replace these hardcoded items with real data from your API
    return SettingsState(
      isDarkMode: false,
      roleList: UserRoleResponse(),
      selectedRole: RoleDetail(),
      languageList: const [
        LanguageItem(code: 'en', name: 'English'),
        LanguageItem(code: 'ar', name: 'العربية'),
      ],
      selectedLanguage: null,
      isLoggingOut: false,
      isLoading: false,
      userRoles: UserRoleResponse(),
      roleId: 0,
      selectedRoleName: null,
    );
  }

  SettingsState copyWith({
    bool? isDarkMode,
    UserRoleResponse? roleList,
    RoleDetail? selectedRole,
    int? roleId,
    List<LanguageItem>? languageList,
    LanguageItem? selectedLanguage,
    bool? isLoggingOut,
    bool? isLoading,
    UserRoleResponse? userRoles,
    String? selectedRoleName,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      roleList: roleList ?? this.roleList,
      selectedRole: selectedRole ?? this.selectedRole,
      roleId: roleId ?? this.roleId,
      languageList: languageList ?? this.languageList,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      isLoading: isLoading ?? this.isLoading,
      userRoles: userRoles ?? this.userRoles,
      selectedRoleName: selectedRoleName ?? this.selectedRoleName,
    );
  }
}
