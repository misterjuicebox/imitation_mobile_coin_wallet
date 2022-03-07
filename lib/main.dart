import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/screens/albums_list.dart';
import 'package:imitation_mob_wallet/screens/balance_and_transactions.dart';
import 'package:imitation_mob_wallet/screens/create_wallet.dart';
import 'package:imitation_mob_wallet/screens/enter_amount.dart';
import 'package:imitation_mob_wallet/screens/enter_your_pin.dart';
import 'package:imitation_mob_wallet/screens/review_transaction.dart';
import 'package:imitation_mob_wallet/services/rate_limiter.dart';
import 'package:imitation_mob_wallet/view_models/albums.view_model.dart';
import 'package:imitation_mob_wallet/view_models/currency_display.view_model.dart';
import 'package:imitation_mob_wallet/view_models/pin_display.dart';
import 'package:imitation_mob_wallet/view_models/send_transaction.view_model.dart';
import 'package:provider/provider.dart';

import './constants.dart' as Constants;
import '../screens/balance_and_transactions.dart';
import '../screens/send.dart';
import '../screens/sending.dart';
import '../view_models/imitation.view_model.dart';
import 'view_models/albums.view_model.dart';
import 'view_models/balance_status.view_model.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<Imitation>(create: (_) => Imitation()..initImitation()),
        ChangeNotifierProvider<CurrencyDisplay>(
          create: (_) => CurrencyDisplay(Constants.usd),
        ),
        ChangeNotifierProvider<BalanceStatus>(create: (_) => BalanceStatus.init()),
        ChangeNotifierProvider(create: (_) => SendTransaction()),
        ChangeNotifierProvider(create: (_) => PinDisplay()),
        ChangeNotifierProvider(create: (_) => RateLimiter()),
        ChangeNotifierProvider(create: (_) => AlbumsViewModel()..fetchAlbums())
      ],
      child: ImitationMobWallet(),
    ));

class ImitationMobWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/create_wallet',
        routes: {
          '/balance_and_transactions': (context) => BalanceAndTransactions(),
          '/send': (context) => Send(),
          '/sending': (context) => Sending(),
          '/enter_amount': (context) => EnterAmount(),
          '/review_transaction': (context) => ReviewTransaction(),
          '/enter_your_pin': (context) => EnterYourPin(),
          '/create_wallet': (context) => CreateWallet(),
          '/albums_list': (context) => AlbumsList()
        },
        darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff191919),
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        home: const BalanceAndTransactions());
  }
}
