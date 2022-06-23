import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foda/services/get_it.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetItService.initializeService();

  runApp(const FodaApp());
}
