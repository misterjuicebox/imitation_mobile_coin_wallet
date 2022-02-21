import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './info_box.dart';
import './no_data.dart';
import './transaction_list.dart';
import '../view_models/imitation.view_model.dart';

class TransactionScroll extends StatelessWidget {
  const TransactionScroll();

  @override
  Widget build(BuildContext context) {
    return Consumer<Imitation>(builder: (context, imitation, child) {
      return !imitation.dataLoaded
          ? const NoData()
          : Container(
              height: MediaQuery.of(context).size.height * .65,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      const InfoBox(),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 30, 0, 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Activity',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      TransactionList(),
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
