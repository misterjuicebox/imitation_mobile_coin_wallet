import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/view_models/imitation.view_model.dart';
import 'package:imitation_mob_wallet/view_models/send_transaction.view_model.dart';
import 'package:imitation_mob_wallet/widgets/qr_icon.dart';
import 'package:provider/provider.dart';

import '../models/contact.model.dart';
import '../widgets/contact_row_item.dart';
import '../widgets/line.dart';

class Send extends StatelessWidget {
  void toHome(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }

  void toSending(BuildContext context) {
    Navigator.pushNamed(context, '/sending');
  }

  void goToEnterAmount(BuildContext context) {
    Navigator.pushNamed(context, '/enter_amount');
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
              height: MediaQuery.of(context).size.height * .73,
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text('Your contacts', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
                        ...contacts.map((contact) {
                          return Consumer<SendTransaction>(builder: (context, transaction, child) {
                            return GestureDetector(
                                child: ContactRowItem(contact: contact),
                                onTap: () {
                                  transaction.setContact(contact);
                                  goToEnterAmount(context);
                                });
                          });
                        }),
                      ])))),
        ],
      ),
    );
  }
}
