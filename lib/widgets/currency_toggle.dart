import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart' as Constants;
import '../view_models/currency_display.model.dart';

// class CurrencyToggle extends StatefulWidget {
//   const CurrencyToggle();
//
//   @override
//   _CurrencyToggleState createState() => _CurrencyToggleState();
// }

// class _CurrencyToggleState extends State<CurrencyToggle> {
class CurrencyToggle extends StatelessWidget {
  // String selectedCurrency = Constants.usd;

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyDisplay>(
      builder: (context, imitation, child) {
        return CustomDropdownButton2(
          dropdownWidth: 80.0,
          dropdownDecoration: BoxDecoration(),
          buttonWidth: 80.0,
          buttonHeight: 30.0,
          buttonDecoration: BoxDecoration(
              color: Color(0xff191919),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white70, width: .6)),
          hint: 'Select Item',
          dropdownItems: Constants.currencyOptions,
          value: imitation.currency,
          icon: Icon(CupertinoIcons.chevron_down),
          onChanged: (value) {
            imitation.setCurrencyDisplay(value!);
            // setState(() {
            //   selectedCurrency = value;
            // });
          },
        );
      },
    );
  }
}
