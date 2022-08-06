import 'package:flutter/material.dart';
import 'package:foda/constant/route_name.dart';
import 'package:foda/models/user.dart';
import 'package:foda/repositories/user_repository.dart';
import 'package:foda/services/get_it.dart';
import 'package:foda/services/navigation_service.dart';
import 'package:foda/utils/common.dart';

import '../../components/base_state.dart';

class AuthenticationState extends BaseState {
  final userRepo = locate<UserRepository>();
  final formKey = GlobalKey<FormState>();
  final navigationService = NavigationService.intance;

  BuildContext get context => navigationService.navigatorKey.currentContext!;
  User? currentUser;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoadingGoogle = false;

  AuthenticationState() {
    if (currentUser == null) {
      _userNotifier();
    }
    userRepo.currentUserNotifier.addListener(_userNotifier);
  }

  @override
  void dispose() {
    userRepo.currentUserNotifier.removeListener(_userNotifier);
    super.dispose();
  }

  void registerUser() async {
    final validate = formKey.currentState?.validate();

    if (validate != null && validate == true && isLoading == false) {
      final user = User(
        uid: "",
        email: emailController.text,
        phone: "",
        profileImageUrl: "",
        createdAt: timeNow(),
        updatedAt: timeNow(),
        isActive: true,
        dob: 0,
        favorites: const [],
        name: nameController.text.trim(),
      );

      setLoading(true);
      final register = await userRepo.registerUser(user, passwordController.text.trim());
      setLoading(false);

      if (register.isRight) {
        fodaPrint("Successfully registered a user");
        navigatorToHome();
      } else {
        fodaPrint("${register.left} error");
      }
    }
  }

  void loginUser() async {
    final validate = formKey.currentState?.validate();

    if (validate != null && validate == true && isLoading == false) {
      setLoading(true);

      final register = await userRepo.login(emailController.text.trim(), passwordController.text.trim());
      setLoading(false);

      if (register.isRight) {
        fodaPrint("Successfully login a user");
        navigatorToHome();
      } else {
        fodaPrint("${register.left} error");
      }
    }
  }

  googleSingin() async {
    if (isLoading == false) {
      isLoadingGoogle = true;
      notifyListeners();

      final register = await userRepo.googleSignIn();
      isLoadingGoogle = false;
      notifyListeners();

      if (register.isRight) {
        fodaPrint("Successfully sigin user");
        navigatorToHome();
      } else {
        fodaPrint("${register.left} error");
      }
    }
  }

  void navigatorToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      overviewPath,
      (route) => false,
    );
  }

  void _userNotifier() {
    currentUser = userRepo.currentUserNotifier.value;
    notifyListeners();
  }
}
