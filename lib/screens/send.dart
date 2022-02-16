import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/models/build_and_submit_transaction_response.dart';
import 'package:imitation_mob_wallet/services/api.service.dart';
import 'package:imitation_mob_wallet/utils/transaction.util.dart';
import 'package:imitation_mob_wallet/view_models/imitation.view_model.dart';
import 'package:imitation_mob_wallet/widgets/qr_icon.dart';
import 'package:provider/provider.dart';

import '../models/contact.model.dart';
import '../services/transaction.service.dart';
import '../widgets/contact_row_item.dart';
import '../widgets/error_dialog.dart';
import '../widgets/line.dart';
import '../widgets/slider_button.dart';

class Send extends StatelessWidget {
  void toHome(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }

  void toSending(BuildContext context) {
    Navigator.pushNamed(context, '/sending');
  }

  @override
  Widget build(BuildContext context) {
    final imitation = Provider.of<Imitation>(context);
    final List<Contact> contacts = imitation.contacts;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
            child: IconButton(
              icon: Icon(
                CupertinoIcons.left_chevron,
                color: Colors.white,
                size: 23.0,
              ),
              onPressed: () {
                toHome(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 30),
            child: Row(
              children: [
                Text(
                  'Send MOB',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 20),
            child: Row(
              children: [
                Container(
                    width: 310,
                    height: 40,
                    child: CupertinoTextField(
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      placeholder: 'Enter address or person',
                      padding: EdgeInsets.all(6),
                      placeholderStyle: TextStyle(height: 1.4, color: Colors.white38, fontSize: 11),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(3)),
                    )),
                Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0), child: QrIcon()),
              ],
            ),
          ),
          Line(color: Colors.white70),
          Container(
              padding: EdgeInsets.only(left: 15),
              height: MediaQuery.of(context).size.height * .60,
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text('Your contacts', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
                        ...contacts.map((contact) {
                          return ContactRowItem(contact: contact);
                        }),
                      ])))),
          Line(color: Colors.white70),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 4, 10),
            child: Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white, width: 1.5)),
                child: SliderButton(
                  action: () async {
                    toSending(context);
                    String pmobToSend = TransactionUtil.getRandomPmob();
                    final ApiService submitTransactionResponse =
                        await TransactionService().buildAndSubmitTransaction(pmobToSend);
                    if (submitTransactionResponse.response != null) {
                      imitation.buildAndSetVerifyingTransaction(
                          submitTransactionResponse.response as BuildAndSubmitTransactionResponse);
                      toHome(context);
                    } else {
                      toHome(context);
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext builder) {
                            return ErrorDialog(errorMessage: submitTransactionResponse.errorResponse!);
                          });
                      Future.delayed(Duration(seconds: 5), () => Navigator.pushNamed(context, '/'));
                    }
                  },
                  label: Text(
                    'Slide to Pay',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  icon: Center(
                      child: Icon(
                    CupertinoIcons.arrow_right,
                    color: Colors.black,
                    size: 13.0,
                  )),
                  buttonSize: 46.5,
                  alignLabel: Alignment(.01, 0),
                  width: 370,
                  radius: 8,
                  buttonColor: Colors.white,
                  backgroundColor: Color(0xff191919),
                  highlightedColor: Colors.white,
                  baseColor: Colors.grey,
                  boxShadow: BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                  dismissThresholds: .85,
                )),
          ),
        ],
      ),
    );
  }
}
