import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:khalti_payment_app/view/khalti_payment_page.dart';

void main() {
  runApp(const KhaltiPaymentApp());
}

class KhaltiPaymentApp extends StatelessWidget {
  const KhaltiPaymentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: "test_public_key_09355a52e0cc4f17999e8162f04c285f",
      builder: (context, navigatorKey) {
        return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [Locale('en', 'US'), Locale('ne', 'NP')],
            localizationsDelegates: const [KhaltiLocalizations.delegate],
            theme: ThemeData(
                primaryColor: const Color(0xFF56328c),
                appBarTheme: const AppBarTheme(
                  color: Color(0xFF56328c),
                )),
            title: "Khalti Payment",
            home: KhaltiPaymentPage());
      },
    );
  }
}
