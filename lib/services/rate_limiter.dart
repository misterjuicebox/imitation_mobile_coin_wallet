import 'dart:async';

import 'package:flutter/cupertino.dart';

class RateLimiter with ChangeNotifier {
  // Problem: The server team requests to limit outgoing requests from the application.
// Task: Create a rate limiter to make sure the app sends no more than N requests per unit of time.

// n = 1
// time = 10 seconds

  List<String> _requests = [];

  List<String> get requests => _requests;

  setRequests(List<String> requests) {
    _requests = requests;
  }

  Future<void> timer() async {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (requests.length > 0) {
        print(requests[0]);
        requests.removeAt(0);
      }
    });
  }

  makeRequest(String request) {
    requests.add(request);
    setRequests(requests);
  }
}
