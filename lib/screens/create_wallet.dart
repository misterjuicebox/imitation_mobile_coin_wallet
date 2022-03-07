import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/rate_limiter.dart';

class CreateWallet extends StatelessWidget {
  const CreateWallet();

  @override
  Widget build(BuildContext context) {
    final rateLimiter = Provider.of<RateLimiter>(context);

    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: <Color>[
                          Color(0xff4B54AD),
                          Color(0xff009E7A),
                          Color(0xff07A080),
                          Color(0xff19A68F),
                          Color(0xff37AFA9),
                          Color(0xff61BCCD),
                          Color(0xff9CCEFF),
                          Color(0xff90CDDB),
                          Color(0xff88CCC3),
                          Color(0xff85CCBA),
                          Color(0xff9DD2C4),
                          Color(0xffBDDAD1),
                          Color(0xffD1DFD9),
                          Color(0xffD8E1DC),
                          Color(0xffF2FAFC),
                        ], // red to yellow
                        tileMode: TileMode.repeated, // repeats the gradient over the canvas
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  width: 300,
                  height: 55,
                  padding: EdgeInsets.all(5),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Align(
                      child: Text('Create wallet'),
                      alignment: Alignment.center,
                    ),
                    decoration: BoxDecoration(
                        color: const Color(0xff191919), borderRadius: BorderRadius.circular(5), border: Border.all()),
                  ),
                ),
                onTap: () => rateLimiter.makeRequest('Create wallet'),
              )
            ],
          )
        ],
      )),
    );
  }
}
