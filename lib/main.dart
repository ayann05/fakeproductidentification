import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fpidapp/dashboard/initial/selection.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FakeProductIdentification());
}

class FakeProductIdentification extends StatefulWidget {
  const FakeProductIdentification({super.key});

  @override
  State<FakeProductIdentification> createState() =>
      _FakeProductIdentificationState();
}

class _FakeProductIdentificationState extends State<FakeProductIdentification> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.comfortaa().fontFamily),
      routes: {'/': (context) => SelectionPage()},
    );
  }
}
