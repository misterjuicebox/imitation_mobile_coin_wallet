import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/screens/balance_and_transactions.dart';
import 'package:imitation_mob_wallet/screens/enter_amount.dart';
import 'package:imitation_mob_wallet/screens/review_transaction.dart';
import 'package:imitation_mob_wallet/view_models/currency_display.model.dart';
import 'package:imitation_mob_wallet/view_models/send_transaction.dart';
import 'package:provider/provider.dart';

import './constants.dart' as Constants;
import '../screens/balance_and_transactions.dart';
import '../screens/send.dart';
import '../screens/sending.dart';
import '../view_models/imitation.view_model.dart';
import 'models/balance_status.model.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<Imitation>(create: (_) => Imitation()..initImitation()),
        ChangeNotifierProvider<CurrencyDisplay>(
          create: (_) => CurrencyDisplay(Constants.usd),
        ),
        ChangeNotifierProvider<BalanceStatus>(create: (_) => BalanceStatus.init()),
        ChangeNotifierProvider(create: (_) => SendTransaction())
      ],
      child: ImitationMobWallet(),
    ));

class ImitationMobWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/balance_and_transactions',
        routes: {
          '/balance_and_transactions': (context) => BalanceAndTransactions(),
          '/send': (context) => Send(),
          '/sending': (context) => Sending(),
          '/enter_amount': (context) => EnterAmount(),
          '/review_transaction': (context) => ReviewTransaction()
        },
        darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff191919),
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        home: const BalanceAndTransactions());
  }
}
