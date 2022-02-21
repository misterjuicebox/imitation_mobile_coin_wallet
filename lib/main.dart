import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/screens/balance_and_transactions.dart';
import 'package:imitation_mob_wallet/view_models/currency_display.model.dart';
import 'package:provider/provider.dart';

import './constants.dart' as Constants;
import '../screens/balance_and_transactions.dart';
import '../screens/send.dart';
import '../screens/sending.dart';
import '../view_models/imitation.view_model.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<Imitation>(
          create: (_) => Imitation()..initImitation(),
        ),
        ChangeNotifierProvider<CurrencyDisplay>(
          create: (_) => CurrencyDisplay(Constants.usd),
        ),
      ],
      child: ImitationMobWallet(),
    ));

class ImitationMobWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/',
        routes: {
          '/send': (context) => Send(),
          '/sending': (context) => Sending(),
        },
        darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff191919),
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        home: const BalanceAndTransactions());
  }
}
