import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/widgets/error_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/key_pad.dart';
import '../widgets/pin_dots.dart';

class EnterYourPin extends StatefulWidget {
  EnterYourPin();

  @override
  State<EnterYourPin> createState() => _EnterYourPinState();
}

class _EnterYourPinState extends State<EnterYourPin> {
  String _pin = '';

  String get pin => _pin;

  setPin(String pin) {
    setState(() {
      _pin = pin;
    });
  }

  void add(String value, BuildContext context) {
    if (pin.length < 6) setPin(pin + value);
    if (pin.length == 6) checkValue(context);
  }

  void remove() {
    if (pin.length > 0) setPin(pin.substring(0, pin.length - 1));
  }

  checkValue(context) async {
    final prefs = await SharedPreferences.getInstance();
    if (pin == prefs.getString('pin')) {
      Navigator.pushNamed(context, '/balance_and_transactions');
    } else {
      Future.delayed(Duration(milliseconds: 100), () {
        setPin('');
      });
      showCupertinoModalPopup(
          context: context,
          builder: (BuildContext builder) {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .65),
              child: Column(
                children: [
                  ErrorDialog(
                    errorMessage: 'The PIN you entered does not match. Please try again.',
                    error: true,
                  )
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Text(
              'Enter your PIN',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(padding: const EdgeInsets.fromLTRB(40, 65, 40, 0), child: PinDots(pin: pin)),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 170, 15, 35),
            child: KeyPad(add: add, remove: remove),
          ),
          Text(
            'I forgot my PIN',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
