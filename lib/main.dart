import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/screens/balance_and_transactions.dart';
import 'package:provider/provider.dart';

import '../screens/balance_and_transactions.dart';
import '../screens/send.dart';
import '../screens/sending.dart';
import '../view_models/imitation.view_model.dart';

void main() => runApp(ChangeNotifierProvider<Imitation>(
      create: (_) => Imitation()..initImitation(),
      child: ImitationMobWallet(),
    ));

class ImitationMobWallet extends StatefulWidget {
  @override
  State<ImitationMobWallet> createState() => _ImitationMobWalletState();
}

class _ImitationMobWalletState extends State<ImitationMobWallet> {
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
        home: BalanceAndTransactions());
  }
}
